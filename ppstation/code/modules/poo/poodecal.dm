//PP content

//Piles of poo

/obj/effect/decal/cleanable/poopdecal
	name = "poo"
	desc = "A mighty log."
	icon = 'ppstation/icons/poo.dmi'
	icon_state = "Logs"
	layer = 2.09 //Sorry LIBERALS
	turf_loc_check = FALSE
	mergeable_decal = FALSE

	var/poopitem = /obj/item/reagent_containers/food/snacks/poo

/obj/effect/decal/cleanable/poopdecal/pellets

	desc = "A pile of poo."
	icon_state = "Pellets"
	poopitem = /obj/item/reagent_containers/food/snacks/poo/pellets

/obj/effect/decal/cleanable/poopdecal/liquid

	desc = "A puddle of liquid poo."
	icon_state = "Runny"
	poopitem = /obj/item/reagent_containers/food/snacks/poo/liquid


/obj/effect/decal/cleanable/poopdecal/clown

	desc = "A happy rainbow poo."
	icon_state = "ClownTurd"
	poopitem = /obj/item/reagent_containers/food/snacks/poo/clown

/obj/effect/decal/cleanable/poopdecal/proc/on_slip(mob/living/carbon/human/H)
	//c&p from poo.dm
	new/obj/effect/decal/cleanable/poopsplash(src.loc)
	var/mutable_appearance/shiddoverlay = mutable_appearance('ppstation/icons/poo.dmi')
	shiddoverlay.icon_state = "Shitoverlay"
	playsound(H, "desceration", 50, TRUE)
	if(!H.shidded) // one layer at a time
		H.add_overlay(shiddoverlay)
		H.shidded = TRUE
		//TODO: handle it in moods
		//SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "creampie", /datum/mood_event/creampie)
	qdel(src)

/obj/effect/decal/cleanable/poopdecal/Initialize()
	. = ..()
	src.dir = pick(1, 2, 4, 8)
	reagents.add_reagent("poo", 20)
	AddComponent(/datum/component/slippery, 80, NO_SLIP_WHEN_WALKING, CALLBACK(src, .proc/on_slip))
	pixel_x = rand(-10, 10)
	pixel_y = rand(-10, 10)

/obj/effect/decal/cleanable/poopdecal/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(iscyborg(user) || isalien(user))
		return

	to_chat(user, "<span class='notice'>You scoop up some poo in your hand.</span>")

	var/obj/item/reagent_containers/food/snacks/poo/newpoo = new poopitem(user.loc)
	user.put_in_hands(newpoo)

	new/obj/effect/decal/cleanable/poopdirt(src.loc)

	qdel(src)


//Splash poo

/obj/effect/decal/cleanable/poopsplash

	name = "poo"
	desc = "A splash of poo."
	icon = 'ppstation/icons/poo.dmi'
	icon_state = "Splatter"

/obj/effect/decal/cleanable/poopsplash/Initialize()
	. = ..()
	src.dir = pick(1, 2, 3, 4, 5, 6, 7, 8)
	reagents.add_reagent("poo", 10)
	pixel_x = rand(-5, 5)
	pixel_y = rand(-5, 5)

//Residual poo dirt

/obj/effect/decal/cleanable/poopdirt

	name = "poo"
	desc = "Some remains of poo."
	icon = 'ppstation/icons/poo.dmi'
	icon_state = "Splatter2"

/obj/effect/decal/cleanable/poopdirt/Initialize()
	. = ..()
	src.dir = pick(1, 2, 4, 8)
	reagents.add_reagent("poo", 5)
	pixel_x = rand(-5, 5)
	pixel_y = rand(-5, 5)
//
//welcome to the land of
//PEE
//population: 14 peellion
//

/obj/effect/decal/cleanable/peepuddle

	name = "pee"
	desc = "A puddle of pee."
	icon = 'ppstation/icons/poo.dmi'
	icon_state = "Piss"

	turf_loc_check = FALSE

/obj/effect/decal/cleanable/peepuddle/Initialize()
	. = ..()
	src.dir = pick(1, 2, 4, 8)
	reagents.add_reagent("pee", 10)
	AddComponent(/datum/component/slippery, 60, NO_SLIP_WHEN_WALKING)
	addtimer(CALLBACK(src, .proc/dry), 1 MINUTES)
	pixel_x = rand(-5, 5)
	pixel_y = rand(-5, 5)

/obj/effect/decal/cleanable/peepuddle/proc/dry()
	qdel(src)