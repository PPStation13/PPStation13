/datum/martial_art
	var/name = "Martial Art"
	var/id = "" //ID, used by mind/has_martialart
	var/streak = ""
	var/max_streak_length = 6
	var/current_target
	var/datum/martial_art/base // The permanent style. This will be null unless the martial art is temporary
	var/deflection_chance = 0 //Chance to deflect projectiles
	var/block_chance = 0 //Chance to block melee attacks using items while on throw mode.
	var/restraining = 0 //used in cqc's disarm_act to check if the disarmed is being restrained and so whether they should be put in a chokehold or not
	var/help_verb
	var/no_guns = FALSE
	var/allow_temp_override = TRUE //if this martial art can be overridden by temporary martial arts

/datum/martial_art/proc/disarm_act(mob/living/carbon/human/A, mob/living/carbon/human/D)
	return 0

/datum/martial_art/proc/harm_act(mob/living/carbon/human/A, mob/living/carbon/human/D)

		//PP WAS HERE: CURBSTOMPING!!!!
		//WRITTEN BY WOROSS
		//to use, you also have to add a curbstomping variable to the human defines
	if( !(D.mobility_flags & MOBILITY_STAND) && get_turf(A) == get_turf(D) && !A.curbstomping && A.zone_selected == BODY_ZONE_HEAD)
		D.visible_message("<span class='warning'>[A] prepares to curbstomp [D]!</span>", "<span class='warning'>[A] prepares to curbstomp you!</span>")

		A.curbstomping = TRUE

		if((!do_mob(A, D, 150) || A.zone_selected != BODY_ZONE_HEAD))
			D.visible_message("<span class='notice'>[A] has stepped away from [D]'s head.</span>", "<span class='notice'>[A] has stepped away from your head.</span>")
			A.curbstomping = FALSE
			return 1

		A.Stun(1000000)
		A.say("Now say goodnight!") //RIP

		var/increment = (( D.lying / 90 ) - 2) //disgusting
		for(var/i in 1 to 5)
			A.pixel_y = A.pixel_y+5
			A.pixel_x = A.pixel_x - increment
			sleep(0.2)
		for(var/i in 1 to 5)
			A.pixel_y = A.pixel_y-5
			A.pixel_x = A.pixel_x - increment
			sleep(0.2)
			
		if(!(A.zone_selected == BODY_ZONE_HEAD &&!(D.mobility_flags & MOBILITY_STAND) && get_turf(A) == get_turf(D)))
			A.curbstomping = FALSE
			return 1

		var/turf/T = get_turf(D)
		var/turf/target = get_ranged_target_turf(D, turn(D.dir, rand(1,360)), 2)
		playsound(A, 'sound/effects/hit_punch.ogg', 80, 1, -1)
		playsound(A, 'ppstation/sound/crunch.wav', 100, 1, 5)
		playsound(A, 'sound/effects/blobattack.ogg', 80, 1, 5)
		for(var/mob/M in urange(8, A))
			shake_camera(M, 2, 3)
		var/obj/item/organ/brain/B = D.getorganslot(ORGAN_SLOT_BRAIN)
		if(B)
			B.Remove(D)
			B.forceMove(T)
			var/datum/callback/gibspawner = CALLBACK(GLOBAL_PROC, /proc/spawn_atom_to_turf, /obj/effect/gibspawner/generic, B, 1, FALSE, D)
			B.throw_at(target, 2, 1, callback=gibspawner)

		if(D.get_damage_amount() > 190)
			D.gib()
		else
			D.apply_damage_type(200)

		A.SetStun(0)
		A.curbstomping = FALSE

		for(var/i in 1 to 10) //Fix the curbstomper's offset
			A.pixel_x = A.pixel_x + increment
			sleep(0.1)

		D.visible_message("<span class='warning'>[A] curbstomps [D]!</span>", "<span class='warning'>[A] curbstomps you!</span>")
		log_combat(A, D, "curbstomped")
		return 1

	else

		return 0

/datum/martial_art/proc/grab_act(mob/living/carbon/human/A, mob/living/carbon/human/D)
	return 0

/datum/martial_art/proc/can_use(mob/living/carbon/human/H)
	return TRUE

/datum/martial_art/proc/add_to_streak(element,mob/living/carbon/human/D)
	if(D != current_target)
		current_target = D
		streak = ""
		restraining = 0
	streak = streak+element
	if(length(streak) > max_streak_length)
		streak = copytext(streak,2)
	return

/datum/martial_art/proc/basic_hit(mob/living/carbon/human/A,mob/living/carbon/human/D)

	var/damage = rand(A.dna.species.punchdamagelow, A.dna.species.punchdamagehigh)

	var/atk_verb = A.dna.species.attack_verb
	if(!(D.mobility_flags & MOBILITY_STAND))

		atk_verb = "kick"

	switch(atk_verb)
		if("kick")
			A.do_attack_animation(D, ATTACK_EFFECT_KICK)
		if("slash")
			A.do_attack_animation(D, ATTACK_EFFECT_CLAW)
		if("smash")
			A.do_attack_animation(D, ATTACK_EFFECT_SMASH)
		else
			A.do_attack_animation(D, ATTACK_EFFECT_PUNCH)

	if(!damage)
		playsound(D.loc, A.dna.species.miss_sound, 25, 1, -1)
		D.visible_message("<span class='warning'>[A] has attempted to [atk_verb] [D]!</span>", \
			"<span class='userdanger'>[A] has attempted to [atk_verb] [D]!</span>", null, COMBAT_MESSAGE_RANGE)
		log_combat(A, D, "attempted to [atk_verb]")
		return 0

	var/obj/item/bodypart/affecting = D.get_bodypart(ran_zone(A.zone_selected))
	var/armor_block = D.run_armor_check(affecting, "melee")

	playsound(D.loc, A.dna.species.attack_sound, 25, 1, -1)
	D.visible_message("<span class='danger'>[A] has [atk_verb]ed [D]!</span>", \
			"<span class='userdanger'>[A] has [atk_verb]ed [D]!</span>", null, COMBAT_MESSAGE_RANGE)

	D.apply_damage(damage, A.dna.species.attack_type, affecting, armor_block)

	log_combat(A, D, "punched")

	if((D.stat != DEAD) && damage >= A.dna.species.punchstunthreshold)
		D.visible_message("<span class='danger'>[A] has knocked [D] down!!</span>", \
								"<span class='userdanger'>[A] has knocked [D] down!</span>")
		D.apply_effect(40, EFFECT_KNOCKDOWN, armor_block)
		D.forcesay(GLOB.hit_appends)
	else if(!(D.mobility_flags & MOBILITY_STAND))
		D.forcesay(GLOB.hit_appends)
	return 1

/datum/martial_art/proc/teach(mob/living/carbon/human/H,make_temporary=0)
	if(!istype(H) || !H.mind)
		return FALSE
	if(H.mind.martial_art)
		if(make_temporary)
			if(!H.mind.martial_art.allow_temp_override)
				return FALSE
			store(H.mind.martial_art,H)
		else
			H.mind.martial_art.on_remove(H)
	else if(make_temporary)
		base = H.mind.default_martial_art
	if(help_verb)
		H.verbs += help_verb
	H.mind.martial_art = src
	return TRUE

/datum/martial_art/proc/store(datum/martial_art/M,mob/living/carbon/human/H)
	M.on_remove(H)
	if(M.base) //Checks if M is temporary, if so it will not be stored.
		base = M.base
	else //Otherwise, M is stored.
		base = M

/datum/martial_art/proc/remove(mob/living/carbon/human/H)
	if(!istype(H) || !H.mind || H.mind.martial_art != src)
		return
	on_remove(H)
	if(base)
		base.teach(H)
	else
		var/datum/martial_art/X = H.mind.default_martial_art
		X.teach(H)

/datum/martial_art/proc/on_remove(mob/living/carbon/human/H)
	if(help_verb)
		H.verbs -= help_verb
	return
