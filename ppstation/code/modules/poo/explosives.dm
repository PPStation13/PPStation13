///////////////////////////////////////
///////POO EXPLOSIVES//////////////////
///////////////////////////////////////

/obj/item/grenade/p4
	name = "P4"
	desc = "An explosive charge. Made out of poo and cheap circuitry."
	icon_state = "p40"
	item_state = "p4"
	gender = PLURAL

/obj/item/grenade/p4/prime()
	update_mob()
	var/poo_place = get_turf(src)
	explosion(src.loc,0,0,2,flame_range = 2)
	spawn(world.tick_lag * 3) new/obj/effect/gibspawner/poo(poo_place)
	qdel(src)



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
		user.put_in_hands(new/obj/item/grenade/p4)
		return

