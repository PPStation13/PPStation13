/obj/machinery/vault
	name = "bluespace vault"
	desc = "A high-tech vault for long-term item storage."
	icon = 'ppstation/icons/bank.dmi'
	icon_state = "vault"

	idle_power_usage = 5 //Quite low
	power_channel = EQUIP
	max_integrity = 300

	density = TRUE
	var/slot = 1
	var/open = FALSE
	var/close_canceled = FALSE
	var/can_open = TRUE
	var/can_close = 0
	var/last_activate = 0

	var/obj/item/inserted_item = null

/obj/machinery/vault/attack_hand(mob/living/user)
	if(!open)
		if(can_open)
			can_open = FALSE
			icon_state = "vault-opening"
			playsound(src, 'sound/machines/windowdoor.ogg', 50, 1, 5)
			spawn(8)
				icon_state = "vault-open"
				open = TRUE
			spawn(40)
				close_vault()
	else
		if(world.time >= last_activate + 20 && inserted_item == null)
			if(IsGuestKey(user.key))
				to_chat(user, "<span class='warning'>This feature is only available to registered users.</span>")
				return
			play_effect()
			playsound(src, 'ppstation/sound/vault_get.ogg', 50, 1, 5)
			last_activate = world.time
			retrieve_item(user)
			can_close = world.time + 40
			spawn(40)
				close_vault()


/obj/machinery/vault/proc/retrieve_item(mob/living/user)
	var/obj/item/ret = null
	ret = get_slot_item(user)
	if(!ret)
		return
	else
		user.put_in_hands(ret)

/obj/machinery/vault/attackby(obj/item/I, mob/living/user, params)
	if(I.vaultable && open && world.time >= last_activate + 20 )
		if(put_slot_item(user, I))
			qdel(I)
			last_activate = world.time
			play_effect()
			playsound(src, 'ppstation/sound/vault_put.ogg', 50, 1, 5)


			can_close = world.time + 40
			spawn(40)
				close_vault()
			return
	..()


//Cosmetic procs
/obj/machinery/vault/proc/play_effect()
	cut_overlays(OBJ_LAYER + 0.1)

	add_overlay("use_effect", OBJ_LAYER + 0.1)
	spawn(20)
		cut_overlays(OBJ_LAYER + 0.1)

/obj/machinery/vault/proc/close_vault()
	if(world.time >= can_close)
		open = FALSE
		icon_state = "vault-closing"
		playsound(src, 'sound/machines/windowdoor.ogg', 50, 1, 5)
		spawn(8)
			can_open = TRUE
			icon_state = "vault"



