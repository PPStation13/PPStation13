/datum/objective_item/steal/mimemask
	name = "the fun-hating mime's mask"
	targetitem = /obj/item/clothing/mask/gas/mime

/datum/objective_item/steal/clownmask
	name = "the mocking clown's mask"
	targetitem = /obj/item/clothing/mask/gas/clown_hat


/datum/antagonist/clown
	name = "Clown"
	show_in_antagpanel = TRUE
	show_name_in_check_antagonists = TRUE

/datum/antagonist/clown/proc/forge_objectives()
	var/datum/objective/steal/steal = new
	steal.set_target(new/datum/objective_item/steal/mimemask)
	steal.owner = owner
	objectives += steal

/datum/antagonist/clown/on_gain()
	owner.special_role = "clown"
	forge_objectives()
	to_chat(owner, "<span class='warning'>Please note that you aren't a traitor and are only allowed to harm the mime.</span>")
	. = ..()

/datum/antagonist/mime
	name = "Mime"
	show_in_antagpanel = TRUE
	show_name_in_check_antagonists = TRUE

/datum/antagonist/mime/proc/forge_objectives()
	var/datum/objective/steal/steal = new
	steal.set_target(new/datum/objective_item/steal/clownmask)
	steal.owner = owner
	objectives += steal

/datum/antagonist/mime/on_gain()
	owner.special_role = "mime"
	forge_objectives()
	to_chat(owner, "<span class='warning'>Please note that you aren't a traitor and are only allowed to harm the clown.</span>")
	. = ..()


/datum/job/clown/after_spawn(mob/living/carbon/human/H, mob/M)
	H.mind.add_antag_datum(/datum/antagonist/clown)
	..()

/datum/job/mime/after_spawn(mob/living/carbon/human/H, mob/M)
	H.mind.add_antag_datum(/datum/antagonist/mime)
	..()