proc/generate_random_unusual_hat(var/luck_modifier = 0)
	var/new_hat = null
	var/new_effect = null

	var/obj/item/clothing/head/ret = null

	var/hat_rarity    = rand(1,100) + luck_modifier
	var/effect_rarity = rand(1,100) + luck_modifier

	if(hat_rarity < 60)
		new_hat = pick(hats_common)
	else if(hat_rarity < 90)
		new_hat = pick(hats_uncommon)
	else
		new_hat = pick(hats_rare)

	if(effect_rarity < 60)
		new_effect = pick(effects_common)
	else if(hat_rarity < 85)
		new_effect = pick(effects_uncommon)
	else
		new_effect = pick(effects_rare)

	ret = new new_hat(src)
	ret.apply_unusual_effect(new_effect)
	return ret

/obj/item/clothing/head/proc/apply_unusual_effect(effect_name)

	var/mutable_appearance/effect = null
	effect = mutable_appearance('ppstation/icons/unusual_effects.dmi', effect_name)
	if(!effect)
		return 0
	unusual_effect = effect_name
	add_overlay(effect)
	name  = "unusual " + name
	desc += " Unusual effect: " + effect_name
	vaultable = TRUE
	return 1