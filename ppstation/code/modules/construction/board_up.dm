/* Board up windows, doors, and mineral doors with this one simple trick! */

/obj/proc/board_up(mob/user, obj/item/I)
	if(istype(I, /obj/item/stack/sheet/mineral/wood))
		var/obj/item/stack/sheet/mineral/wood/W = I
		if(locate(/obj/structure/barricade/crude) in loc.contents)
			to_chat(user, "<span class='warning'>This is already boarded up.</span>")
			return TRUE
		if(W.amount < 3)
			to_chat(user, "<span class='warning'>You need 3 planks to board something up.</span>")
			return TRUE
		to_chat(user, "<span class='notice'>You begin boarding up the [src]...</span>")
		if(!do_mob(user, user, 30))
			return TRUE
		if(locate(/obj/structure/barricade/crude) in loc.contents)
			to_chat(user, "<span class='warning'>This is already boarded up.</span>")
			return TRUE
		if(W.use(3) == 0)
			user.dropItemToGround(W)
			qdel(W)
		new/obj/structure/barricade/crude(loc)
		return TRUE
	else
		return FALSE