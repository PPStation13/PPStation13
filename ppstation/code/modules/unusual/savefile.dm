#define BANK_VERSION 2

/obj/machinery/vault/proc/savefile_path(mob/living/user)
	return "data/player_saves/[copytext(user.ckey, 1, 2)]/[user.ckey]/bank.sav"

/obj/machinery/vault/proc/put_slot_item(mob/living/user, obj/item/slot_item)

	if(IsGuestKey(user.key))
		return 0

	var/path = savefile_path(user)
	var/savefile/F = new /savefile(path)
	if(!F)
		return

	var/slot_empty = TRUE
	F["slot[slot]_empty"] >> slot_empty
	if (slot_empty == FALSE)
		to_chat(user, "<span class='warning'>Slot [slot] is full!</span>")
		return 0

	WRITE_FILE(F["slot[slot]_type"], slot_item.type)

	if(istype(slot_item, /obj/item/stack))
		var/obj/item/stack/I = slot_item
		WRITE_FILE(F["slot[slot]_amount"], I.amount)
	else
		WRITE_FILE(F["slot[slot]_amount"], 0)

	if(istype(slot_item, /obj/item/clothing/head))
		var/obj/item/clothing/head/I = slot_item
		WRITE_FILE(F["slot[slot]_effect"], I.unusual_effect)
	else
		WRITE_FILE(F["slot[slot]_effect"], 0)

	WRITE_FILE(F["slot[slot]_empty"], FALSE)
	WRITE_FILE(F["version"], BANK_VERSION)
	to_chat(user, "<span class='notice'>You put the [slot_item] into the slot [slot] vault.</span>")
	return 1

/obj/machinery/vault/proc/get_slot_item(mob/living/user)

	var/obj/item/ret
	var/path = savefile_path(user)

	if (!fexists(path))
		return 0

	var/savefile/F = new /savefile(path)

	if(!F)
		return

	var/version = null
	F["version"] >> version

	if (isnull(version) || version != BANK_VERSION)
		fdel(path)
		to_chat(user, "<span class='warning'>Corrupt data detected in your bank account. Deleting all items...</span>")
		playsound(src.loc, 'sound/effects/splat.ogg', 50, 1)
		return 0


	var/item_type = null
	F["slot[slot]_type"] >> item_type
	if (isnull(item_type) || item_type == 0 )
		clear_slot(user)
		return null

	ret = new item_type(src)
	if(istype(ret, /obj/item/stack))
		var/obj/item/stack/I = ret
		var/item_amount = 0
		F["slot[slot]_amount"] >> item_amount
		if(item_amount != 0)
			I.amount = item_amount
		else
			qdel(ret)
			clear_slot(user)
			return null
	else if(istype(ret, /obj/item/clothing/head))
		var/obj/item/clothing/head/I = ret
		var/item_unusual_effect = 0
		F["slot[slot]_effect"] >> item_unusual_effect
		if(item_unusual_effect !=0)
			I.apply_unusual_effect(item_unusual_effect)

	to_chat(user, "<span class='notice'>You take the [ret] out of the slot [slot] vault.</span>")
	clear_slot(user)
	return ret

/obj/machinery/vault/proc/clear_slot(mob/living/user)

	if(IsGuestKey(user.key))
		return 0

	var/savefile/F = new /savefile(src.savefile_path(user))

	var/msg = ""
	F["slot[slot]_empty"] >> msg
	F["slot[slot]_type"] >> msg


	WRITE_FILE(F["slot[slot]_empty"], TRUE)
	WRITE_FILE(F["slot[slot]_type"], 0)
	WRITE_FILE(F["slot[slot]_amount"], 0)
	WRITE_FILE(F["slot[slot]_effect"], 0)
	WRITE_FILE(F["version"], BANK_VERSION)

	F["slot[slot]_empty"] >> msg
	F["slot[slot]_type"] >> msg


	return