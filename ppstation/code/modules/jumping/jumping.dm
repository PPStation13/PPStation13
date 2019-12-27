/mob/living/carbon/proc/pp_jump(atom/A, stamcost = TRUE) //AKA BLOODY JUMP

	face_atom(A)
	if( (mobility_flags & (MOBILITY_MOVE)) && (mobility_flags & (MOBILITY_STAND)) && (has_gravity() || A.has_gravity()) && !jumping && (!handcuffed || !pulledby) /*stay De Morganmad liberals*/ && !legcuffed )

		if(getStaminaLoss() > 60 && stamcost)
			return
		jumping = TRUE
		weather_immunities += "lava"
		pass_flags |= PASSMOB
		pass_flags |= LETPASSTHROW
		if(stamcost)
			adjustStaminaLoss(20)
		density = 0
		throw_at(A, 2, 1, src, FALSE, TRUE, callback = CALLBACK(src, .proc/jump_end))
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
	while(pixel_y > 0)
		pixel_y = pixel_y-3
		sleep(0.1)
	pixel_y = 0
	jumping = FALSE

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
