/* Misc Props */
/* ---------- */

/obj/structure/sign/plaques/kiddie/bank
	name = "Introduction to banking"
	desc = "Each of these expensive banking vaults can store our clients' goods, persistently, forever. To deposit, open a vault and insert a supported item. The item will be secured instantly. To withdraw, open a vault and reach in. If you have anything stored inside, you will receive the item immediately. Currently, you can bank the following items: poo, PPCoin, and extraordinarily rare hats. We do not take responsibility for damaged goods."


/* Vault      */
/* ---------- */

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



/* Money Printer */
/* ------------- */

GLOBAL_VAR_INIT(inflation_level, 100)

/obj/machinery/money_printer/
	name = "money printer"
	desc = "A machine that prints new cash. Irresponsible use could lead to economic turmoil."
	icon = 'ppstation/icons/bank.dmi'
	icon_state = "money_printer"

	idle_power_usage = 5
	power_channel = EQUIP
	max_integrity = 500

	density = TRUE
	var/busy = FALSE
	var/last_activate = -1200
	var/strength = 10

/obj/machinery/money_printer/attack_hand(mob/living/user)
	if (busy)
		return ..()
	if ( world.time >= last_activate + 1200 )
		last_activate = world.time
	else
		to_chat(user, "<span class='notice'>The machine is cooling down, please wait...</span>")
		return ..()

	if(user.mind.assigned_role == "Rabbi" || user.mind.assigned_role == "Banker" )
		to_chat(user, "<span class='notice'>You activate the machine.</span>")
		busy = TRUE
		icon_state = "money_printer-active"
		for (var/i = 0; i< strength; i++)
			new/obj/item/stack/spacecash/c100(src.loc)
			playsound(loc, "pageturn", 90, 1)
			sleep(10)
		busy = FALSE
		icon_state = "money_printer"
		adjust_inflation(user)
	else
		busy = TRUE
		icon_state = "money_printer-danger"
		for(var/obj/machinery/door/poddoor/M in GLOB.machines)
			if(M.id == "bank_printer")
				INVOKE_ASYNC(M, /obj/machinery/door/poddoor.proc/close)
		to_chat(user, "<span class='warning'>This machine is not for you!</span>")
		user.adjustFireLoss(10)
		user.say("*scream")
		spawn(10)
			to_chat(user, "<span class='warning'>You will own nothing!</span>")
			user.adjustFireLoss(20)
			user.say("*scream")
		spawn(20)
			to_chat(user, "<span class='warning'>And you will be happy!</span>")
			user.adjustFireLoss(30)
			user.say("*scream")
		spawn(30)
			to_chat(user, "<span class='danger bold'>Shut it down!</span>")
			explosion(loc,0,0,3,5)
			qdel(src)
	return ..()

/* Nice exponential growth... */
/obj/machinery/money_printer/proc/adjust_inflation(mob/living/user)
	var/coefficient = 1.08 * ((strength+90)/100)

	//first the vending machines
	for(var/obj/machinery/vending/V in GLOB.machines)
		V.default_price *= coefficient
		V.extra_price *=   coefficient
		//Contraband goods not affected by inflation!
		for (var/datum/data/vending_product/P in V.product_records)
			if(P.custom_price)
				P.custom_price *= coefficient
			if(P.custom_premium_price)
				P.custom_premium_price *= coefficient
	//now cargo packs
	for(var/pack in SSshuttle.supply_packs)
		var/datum/supply_pack/P = SSshuttle.supply_packs[pack]
		P.cost *= coefficient