/datum/martial_art/WOMAN
	name = "Catfighting"

/datum/martial_art/WOMAN/harm_act(mob/living/carbon/human/A, mob/living/carbon/human/D)
	A.do_attack_animation(D, ATTACK_EFFECT_PUNCH)
	var/atk_verb = pick("slapp", "loose-fisted punch")
	var/damage = 1 + A.dna.species.punchdamagelow
	if(!damage)
		playsound(D.loc, 'sound/weapons/slap.ogg', 25, 1, -1)
		D.visible_message("<span class='warning'>[A] has attempted to [atk_verb] [D]!</span>", \
			"<span class='userdanger'>[A] has attempted to [atk_verb] [D]!</span>", null, COMBAT_MESSAGE_RANGE)
		log_combat(A, D, "attempted to hit", atk_verb)
		return 0
	var/obj/item/bodypart/affecting = D.get_bodypart(ran_zone(A.zone_selected))
	var/armor_block = D.run_armor_check(affecting, "melee")
	playsound(D.loc, 'sound/weapons/slap.ogg', 25, 1, -1)
	D.visible_message("<span class='danger'>[A] has [atk_verb]ed [D]!</span>", \
			"<span class='userdanger'>[A] has [atk_verb]ed [D]!</span>", null, COMBAT_MESSAGE_RANGE)
	D.apply_damage(damage, STAMINA, affecting, armor_block)
	log_combat(A, D, "slapped (woman) ")
	return 1