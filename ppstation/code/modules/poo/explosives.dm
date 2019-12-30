///////////////////////////////////////
///////POO EXPLOSIVES//////////////////
///////////////////////////////////////

/obj/item/grenade/plastic/p4
	name = "P4"
	desc = "An explosive breaching charge. Made out of poo and cheap circuitry."
	icon_state = "p40"
	item_state = "p4"
	gender = PLURAL
	directional = TRUE
	boom_sizes = list(0, 0, 2)

/obj/item/reagent_containers/food/snacks/poo/pellets/attackby(obj/item/P, mob/user, params)
	if(icon_state == "PelletsInHand" && istype(P, /obj/item/stack/ducttape))
		to_chat(user, "<span class='notice'>You secure the poo with some tape.</span>")
		var/obj/item/stack/ducttape/D = P
		if(D.use(1) == 0)
			user.dropItemToGround(D)
			qdel(D)
		icon_state = "p4_1"
		return
	if(icon_state == "p4_1" && istype(P, /obj/item/stack/cable_coil))
		to_chat(user, "<span class='notice'>You attach some cable.</span>")
		var/obj/item/stack/cable_coil/D = P
		if(D.use(1) == 0)
			user.dropItemToGround(D)
			qdel(D)
		icon_state = "p4_2"
		return
	if(icon_state == "p4_2" && istype(P, /obj/item/assembly/igniter))
		to_chat(user, "<span class='notice'>You connect an igniter. The bomb is ready.</span>")
		qdel(P)
		qdel(src)
		user.put_in_hands(new/obj/item/grenade/plastic/p4)
		return

