/datum/emote/living/carbon/human/poop
	key = "poop"
	key_third_person = "poops"

/datum/emote/living/carbon/human/poop/run_emote(mob/living/carbon/human/user, params)

	message = "poops."
	var/shiddsound = 'ppstation/sound/shidd.ogg'

	if(user.stat != CONSCIOUS)
		to_chat(user, "<span class='warning'>You can't poop while unconscious!</span>")
		return

	if(user.nutrition < NUTRITION_LEVEL_STARVING)
		to_chat(user, "<span class='warning'>You're too hungry to poop!</span>")
		return

	if((user.w_uniform != null) || (user.wear_suit != null && (user.wear_suit.body_parts_covered & GROIN)))
		user.nutrition = max(user.nutrition - 75, NUTRITION_LEVEL_STARVING)
		to_chat(user, "<span class='warning'>You poop yourself!</span>")

		var/mutable_appearance/shiddoverlay = mutable_appearance('ppstation/icons/poo.dmi')
		shiddoverlay.icon_state = "Shitoverlay"

		if(!user.shidded) // one layer at a time
			user.add_overlay(shiddoverlay)
			user.shidded = TRUE

		playsound(user, shiddsound, 50, 1, 5)

		new/obj/effect/decal/cleanable/poopdirt(user.loc)
		return

	else

		if(user.mind.assigned_role == "Clown")
			//Special clown poop
			user.nutrition = max(user.nutrition - 75, NUTRITION_LEVEL_STARVING)
			new/obj/effect/decal/cleanable/poopdecal/clown(user.loc)

			//Special clown poo code here

			message = pick(	"drops a glitter bomb.",
							"makes a happy mistake.",
							"leaves a present!")


			playsound(user, shiddsound, 50, 1, 5)
			user.visible_message("<b>[user]</b> [message]")

			return

		var/obj/item/organ/butt/B = user.getorgan(/obj/item/organ/butt)
		if(!B)
			//Liquid/spray poop
			message = pick(	"lets loose the juice.",
							"rains hell.",
							"blasts a torrent of diarrhea.",
							"sprays feces.")

			user.nutrition = max(user.nutrition - 30, NUTRITION_LEVEL_STARVING)
			new/obj/effect/decal/cleanable/poopdecal/liquid(user.loc)

		else
			//Normal poop

			if(user.nutrition > 300)

				message = pick(	"fards and shids.",
								"makes a big poo poo.",
								"lays cable.",
								"releases massive cargo.",
								"loosens his sphincter and defecates",
								"drops a log.")

				user.nutrition = max(user.nutrition - 75, NUTRITION_LEVEL_STARVING)
				new/obj/effect/decal/cleanable/poopdecal(user.loc)

			else

				message = pick(	"fards and shids.",
								"makes a poo poo!",
								"composts.",
								"fertrilizes the station!",
								"opens the cargo hold.",
								"loosens his sphincter and defecates",
								"carpet bombs.",
								"releases a boulder.")

				user.nutrition = max(user.nutrition - 50, NUTRITION_LEVEL_STARVING)
				new/obj/effect/decal/cleanable/poopdecal/pellets(user.loc)


		playsound(user, shiddsound, 50, 1, 5)
		user.visible_message("<b>[user]</b> [message]")