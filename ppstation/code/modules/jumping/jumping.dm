/mob/living/carbon/proc/pp_jump(atom/A, stamcost = TRUE) //AKA BLOODY JUMP

	face_atom(A)
	if( (mobility_flags & (MOBILITY_MOVE)) && (mobility_flags & (MOBILITY_STAND)) && (has_gravity() || A.has_gravity()) && !jumping && (!handcuffed || !pulledby) /*stay De Morganmad liberals*/ && !legcuffed )

		if(getStaminaLoss() > 60 && stamcost)
			return
		jumping = TRUE
		//movement_type &= FLYING
		weather_immunities += "lava"
		pass_flags |= PASSMOB
		pass_flags |= LETPASSTHROW
		if(stamcost)
			adjustStaminaLoss(20)
		density = 0
		//throw_at(A, 2, 1, src, FALSE, TRUE, callback = CALLBACK(src, .proc/jump_end))
		throw_at(A, 2, 1, src, FALSE, TRUE)
		for(var/i in 1 to 5)
			pixel_y = pixel_y+3
			sleep(0.1)
		spawn() jump_end()
		if(A.loc == loc) //check if we arrived at our destination
			return 1
		else
			return 0

/mob/living/carbon/proc/jump_end()
	weather_immunities -= "lava"
	pass_flags &= ~PASSMOB
	pass_flags &= ~LETPASSTHROW
	density = 1
	var/affected_people = list()
	for(var/mob/living/carbon/M in get_turf(src))
		if(M == src)
			continue
		else
			if(a_intent != INTENT_HELP)
				if(M.mobility_flags & (MOBILITY_STAND) && ishuman(M) && (check_target_facings(src, M) == FACING_SAME_DIR) )
					var/mob/living/carbon/human/H = M
					playsound(H, 'sound/effects/hit_punch.ogg', 100, 1, -1)
					H.visible_message("<span class='danger'>[src] has tackled [H]!</span>",
					"<span class='userdanger'>[src] has tackled [H]!</span>", null, COMBAT_MESSAGE_RANGE)
					H.apply_effect(40, EFFECT_PARALYZE, H.run_armor_check(BODY_ZONE_CHEST, "melee", "Your armor prevents your fall!", "Your armor softens your fall!"))
					H.forcesay(GLOB.hit_appends)
					log_combat(src, H, "tackled")
					affected_people+=H
				else
					continue
	while(pixel_y > 0)
		pixel_y = pixel_y-5
		sleep(0.1)
	pixel_y = 0
	for(var/mob/living/carbon/M in get_turf(src))
		if(M == src)
			continue
		else
			if(a_intent != INTENT_HELP)
				if(!(M.mobility_flags & (MOBILITY_STAND)) && !(M in affected_people))
					playsound(M, 'ppstation/sound/crunch.wav', 75, 1, -1)
					M.apply_damage(10,"brute")
					log_message("stomped on [key_name(M)]", LOG_ATTACK)
					visible_message("<span class='warning'><b>[src]</b> stomps on <b>[M]</b>!</span>", "<span class='warning'>You stomp on <b>[M]</b>!</span>")
	jumping = FALSE
	//movement_type &= !FLYING

/obj/structure/table/Crossed(atom/movable/AM)
	if(iscarbon(AM))
		var/mob/living/carbon/C = AM
		if (C.jumping && !C.IsParalyzed())
			for(var/obj/item/I in C.held_items)
				C.accident(I)
			C.Paralyze(20)
			//for(var/obj/item/I in C.held_items)
			//	var/atom/throw_target = get_edge_target_turf(C, rand(1,360))
			//	I.throw_at(throw_target, pick(2,3), 1)
			to_chat(C, "<span class='warning'>You trip over the table!</span>")
			playsound(C.loc, 'sound/effects/hit_punch.ogg', 50, 1, -1)
