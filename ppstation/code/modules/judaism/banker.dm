/obj/effect/landmark/start/banker
	name = "Banker"
	icon = 'ppstation/icons/jew/jew.dmi'
	icon_state = "jewspawn"

/datum/job/banker
	title = "Banker"
	flag = BANKER
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "G-d"
	selection_color = "#dddddd"
	access = list(ACCESS_BANK, ACCESS_MAINT_TUNNELS)
	minimal_access = list(ACCESS_BANK, ACCESS_MAINT_TUNNELS)
	outfit = /datum/outfit/job/banker
	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_CIV

/datum/job/banker/after_spawn(mob/living/carbon/human/H, mob/M)

	var/obj/item/organ/foreskin/F = H.getorgan(/obj/item/organ/foreskin)
	if(F)
		qdel(F)
	if(H.gender == FEMALE)
		H.gender = MALE
		H.regenerate_icons()
	var/datum/martial_art/S = H.mind.has_martialart("Catfighting")
	if(S)
		S.remove(H)

	var/suffix = pick("stein", "berg", "owitz")
	var/jewname = H.real_name + suffix
	H.fully_replace_character_name(H.real_name, jewname)



/datum/outfit/job/banker
	name = "Banker"
	jobtype = /datum/job/banker
	uniform =  /obj/item/clothing/under/suit_jacket/tan
	shoes = /obj/item/clothing/shoes/sandal
	head = /obj/item/clothing/head/pp/kippah
	neck = /obj/item/clothing/neck/tie/red
	glasses = /obj/item/clothing/glasses/regular