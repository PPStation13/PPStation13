//PP content

//Piles of poo

/obj/effect/decal/cleanable/poopdecal
	name = "poo"
	desc = "A mighty log."
	icon = 'hippiestation/icons/obj/poo.dmi'
	icon_state = "Logs"
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


/obj/effect/decal/cleanable/poopdecal/Initialize()
	. = ..()
	src.dir = pick(1, 2, 4, 8)
	AddComponent(/datum/component/slippery, 80)
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
	icon = 'hippiestation/icons/obj/poo.dmi'
	icon_state = "Splatter"

/obj/effect/decal/cleanable/poopsplash/Initialize()
	. = ..()
	src.dir = pick(1, 2, 3, 4, 5, 6, 7, 8)
	pixel_x = rand(-5, 5)
	pixel_y = rand(-5, 5)

//Residual poo dirt

/obj/effect/decal/cleanable/poopdirt

	name = "poo"
	desc = "Some remains of poo."
	icon = 'hippiestation/icons/obj/poo.dmi'
	icon_state = "Splatter2"

/obj/effect/decal/cleanable/poopdirt/Initialize()
	. = ..()
	src.dir = pick(1, 2, 4, 8)
	pixel_x = rand(-5, 5)
	pixel_y = rand(-5, 5)