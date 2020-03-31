/*
/mob/living/carbon/human/baby
	ventcrawler = VENTCRAWLER_ALWAYS
	name = "bby"
	icon = 'ppstation/icons/baby.dmi'
	icon_state = "human"

/mob/living/carbon/human/baby/Initialize()
	.=..()
	gender = pick(MALE,FEMALE)
	//color = "#ffe0d1"
	color = "#" + skintone2hex(random_skin_tone())

	var/mutable_appearance/eye_overlay
	eye_overlay = mutable_appearance('ppstation/icons/baby.dmi', "eyes", -BODY_LAYER)
	eye_overlay.color = "#" + random_eye_color()
	add_overlay(eye_overlay)
*/