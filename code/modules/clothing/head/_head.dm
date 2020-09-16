/obj/item/clothing/head
	name = BODY_ZONE_HEAD
	icon = 'icons/obj/clothing/hats.dmi'
	icon_state = "top_hat"
	item_state = "that"
	body_parts_covered = HEAD
	slot_flags = ITEM_SLOT_HEAD
	var/blockTracking = 0 //For AI tracking
	var/can_toggle = null
	var/unusual_effect = null
	dynamic_hair_suffix = "+generic"

/obj/item/clothing/head/Initialize()
	. = ..()
	if(ishuman(loc) && dynamic_hair_suffix)
		var/mob/living/carbon/human/H = loc
		H.update_hair()

/obj/item/clothing/head/worn_overlays(isinhands = FALSE)
	. = list()
	if(!isinhands)
		if(damaged_clothes)
			. += mutable_appearance('icons/effects/item_damage.dmi', "damagedhelmet")
		IF_HAS_BLOOD_DNA(src)
			. += mutable_appearance('icons/effects/blood.dmi', "helmetblood")
		if(unusual_effect)
			var/mutable_appearance/moved_effect = mutable_appearance('ppstation/icons/unusual_effects.dmi', unusual_effect)
			moved_effect.pixel_y  += 16
			. += moved_effect

/obj/item/clothing/head/update_clothes_damaged_state(damaging = TRUE)
	..()
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_head()