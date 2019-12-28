 //made by woross with the help of Tomeno

/datum/emote/living/carbon/human/poop
	key = "poop"
	key_third_person = "poops"

/datum/emote/living/carbon/human/poop/poo
	key = "poo"

/datum/emote/living/carbon/human/poop/run_emote(mob/living/carbon/human/user, params)

	var/mutable_appearance/shiddoverlay = mutable_appearance('ppstation/icons/poo.dmi')
	shiddoverlay.icon_state = "Shitoverlay"

	message = "poops."
	var/shiddsound = 'ppstation/sound/shidd.ogg'

	//if(user.stat != CONSCIOUS)
	//	to_chat(user, "<span class='warning'>You can't poop while unconscious!</span>")
	//	return
	//BRING BACK UNCONSCIOUS POOPING

	if(user.nutrition < NUTRITION_LEVEL_STARVING)
		to_chat(user, "<span class='warning'>You're too hungry to poop!</span>")
		return

	if((user.w_uniform != null) || (user.wear_suit != null && (user.wear_suit.body_parts_covered & GROIN)))
		user.nutrition = user.nutrition - 75
		to_chat(user, "<span class='warning'>You poop yourself!</span>")

		if(!user.shidded) // one layer at a time
			user.add_overlay(shiddoverlay)
			user.shidded = TRUE

		playsound(user, shiddsound, 50, 1, 5)

		new/obj/effect/decal/cleanable/poopdirt(user.loc)
		return



	else

		for(var/obj/structure/toilet/M in get_turf(user))
			if(M.open == TRUE)
				to_chat(user, "<span class='notice'>You take a peaceful dump into the toilet.</span>")
				playsound(user, shiddsound, 30, 1, 5)
                //I can't believe I'm editing this ancient file, the file that started the spirit of PP Station 13...
                //Such nostalgia.

                //Pooping into a toilet now shits on the other end of the toilet.
                //Eventually I am gonna animate it for the other side, maybe make it splat against the heads of people hit by it.
				var/obj/effect/landmark/sewer/linked_sewer = null
				for(var/obj/effect/landmark/sewer/T in sewers_entrance)
					if(T.code == M.code)
						linked_sewer = T
						break
				if(linked_sewer)
                    //Wow my code a few months ago was utter shit, I should've handled it with variables. Now I'm gonna have to do a trillion ifs, sad
					if(user.mind.assigned_role == "Clown")
                        //Special clown poop
						user.nutrition = user.nutrition - 75
						new/obj/effect/decal/cleanable/poopdecal/clown(linked_sewer.loc)
						return

					var/obj/item/organ/butt/B = user.getorgan(/obj/item/organ/butt)
					if(!B)
						user.nutrition = user.nutrition - 30
						new/obj/effect/decal/cleanable/poopdecal/liquid(linked_sewer.loc)
					else
						if(user.nutrition > 300)
							user.nutrition = user.nutrition - 75
							new/obj/effect/decal/cleanable/poopdecal(linked_sewer.loc)

						else
							user.nutrition = user.nutrition - 50
							new/obj/effect/decal/cleanable/poopdecal/pellets(linked_sewer.loc)
				return

		for(var/obj/item/reagent_containers/glass/bucket/N in get_turf(user))
			if(!(N.reagents.total_volume >= N.reagents.maximum_volume))
				user.nutrition = user.nutrition - 75
				N.reagents.add_reagent("poo", 20)
				to_chat(user, "<span class='notice'>You take a peaceful dump into the bucket.</span>")
				playsound(user, shiddsound, 30, 1, 5)
				return


		for(var/mob/living/M in get_turf(user))
			if(M == user)
				continue
			else
				M.apply_damage(10,"brute","chest")
				user.log_message("pooped on [key_name(M)]", LOG_ATTACK)
				user.visible_message("<span class='warning'><b>[user]</b> poops on <b>[M]</b>!</span>", "<span class='warning'>You poop on <b>[M]</b>!</span>")

				if(ishuman(M))
					var/mob/living/carbon/human/H = M
					if(!H.shidded) // one layer at a time
						H.add_overlay(shiddoverlay)
						H.shidded = TRUE

		if(user.mind.assigned_role == "Clown")
			//Special clown poop
			user.nutrition = user.nutrition - 75
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
							"opens the rear valve.",
							"blasts a torrent of diarrhea.",
							"sends for Agent Brown.",
							"brews some hot chocolate.",
							"activates the Mexican jet propulsion!",
							"makes an upside-down hot fudge sundae.",
							"serves hot chili.",
							"serves drippy doo-doo.",
							"splashes some bum gravy.",
							"sprays feces.")

			user.nutrition = user.nutrition - 30
			new/obj/effect/decal/cleanable/poopdecal/liquid(user.loc)

		else
			//Normal poop

			if(user.nutrition > 300)

				message = pick(	"fards and shids.",
								"makes a big poo poo.",
								"makes a poo poo of epic proportions.",
								"fires the rear mortar.",
								"lays cable.",
								"releases massive cargo.",
								"cooks some sausage.",
								"curls some pipe.",
								"drops a brown trout.",
								"makes a core dump.",
								"makes a special delivery.",
								"makes a deposit at the porcelain bank.",
								"saws off a log.",
								"snaps a log.",
								"voids the bowels.",
								"drops a log.")

				user.nutrition = user.nutrition - 75
				new/obj/effect/decal/cleanable/poopdecal(user.loc)

			else

				message = pick(	"fards and shids.",
								"makes a poo poo!",
								"fires the rear guns.",
								"composts.",
								"fertrilizes the station!",
								"opens the cargo hold.",
								"carpet bombs.",
								"bombs the floor.",
								"plants some corn.",
								"releases the barbarians at the gate.",
								"builds a dookie castle!",
								"downloads some brownware.",
								"draws mud.",
								"makes room for lunch.",
								"voids the bowels.",
								"releases a boulder.")

				user.nutrition = user.nutrition - 50
				new/obj/effect/decal/cleanable/poopdecal/pellets(user.loc)


		playsound(user, shiddsound, 50, 1, 5)
		user.visible_message("<b>[user]</b> [message]")


/datum/emote/living/carbon/human/pee
	key = "pee"
	key_third_person = "pees"

/datum/emote/living/carbon/human/pee/run_emote(mob/living/carbon/human/user, params)

	message = "pees."
	var/peesound = 'ppstation/sound/pee.ogg'

	var/t_himself
	if(user.gender == MALE)
		t_himself = "himself"
	else if(user.gender == FEMALE)
		t_himself = "herself"

	//if(user.canpee == FALSE)
	if(user.lastpee > world.time - 1000)
		to_chat(user, "<span class='warning'>You don't want to!</span>")
		return



	else
		//user.canpee = FALSE
		user.lastpee = world.time

		for(var/obj/structure/toilet/M in get_turf(user))
			if(M.open == TRUE)
				to_chat(user, "<span class='notice'>You pee into the toilet peacefully.</span>")
				playsound(user, peesound, 60, 1, 5)
				return

		for(var/obj/item/reagent_containers/glass/bucket/N in get_turf(user))
			if(!(N.reagents.total_volume >= N.reagents.maximum_volume))
				N.reagents.add_reagent("pee", 10)
				to_chat(user, "<span class='notice'>You pee into the bucket peacefully.</span>")
				playsound(user, peesound, 100, 1, 5)
				return

		for(var/mob/living/M in get_turf(user))
			if(M == user)
				continue
			else
				M.apply_damage(20, "STAMINA")
				user.log_message("peed on [key_name(M)]", LOG_ATTACK)
				user.visible_message("<span class='warning'><b>[user]</b> pees on <b>[M]</b>!</span>", "<span class='warning'>You pee on <b>[M]</b>!</span>")

				SEND_SIGNAL(M, COMSIG_COMPONENT_CLEAN_ACT, CLEAN_WEAK)
				M.wash_cream()
				M.remove_atom_colour(WASHABLE_COLOUR_PRIORITY)

				M.adjust_blurriness(1)

		if((user.w_uniform != null) || (user.wear_suit != null && (user.wear_suit.body_parts_covered & GROIN)))
			message = "pees [t_himself]."
		else
			message = pick(	"wets the floor.",
							"makes warm lemonade.",
							"does a wee.",
							"empties the tank.",
							"sprinkles the tinkle.",
							"takes a leak.")
		new/obj/effect/decal/cleanable/peepuddle(user.loc)
		playsound(user, peesound, 85, 1, 5)
		user.visible_message("<b>[user]</b> [message]")
		return

/* MONKEY SECTION - Much simplified poo poo */

/datum/emote/living/carbon/monkey
	mob_type_allowed_typecache = list(/mob/living/carbon/monkey)

/mob/living/carbon/monkey
	var/lastpoo = -1000

/datum/emote/living/carbon/monkey/poop
	key = "monkey_poop"
	key_third_person = "monkey_poops"

/datum/emote/living/carbon/monkey/poop/poo
	key = "monkey_poo"

/datum/emote/living/carbon/monkey/poop/run_emote(mob/living/carbon/monkey/user, params)

	var/mutable_appearance/shiddoverlay = mutable_appearance('ppstation/icons/poo.dmi')
	shiddoverlay.icon_state = "Shitoverlay"

	message = "poops."
	var/shiddsound = 'ppstation/sound/shidd.ogg'

	//if(user.canpee == FALSE)
	if(user.lastpoo > world.time - 1000)
		to_chat(user, "<span class='warning'>You don't want to!</span>")
		return

	else
		user.lastpoo = world.time

		for(var/obj/structure/toilet/M in get_turf(user))
			if(M.open == TRUE)
				to_chat(user, "<span class='notice'>You take a peaceful dump into the toilet.</span>")
				playsound(user, shiddsound, 30, 1, 5)
				return

		for(var/obj/item/reagent_containers/glass/bucket/N in get_turf(user))
			if(!(N.reagents.total_volume >= N.reagents.maximum_volume))
				N.reagents.add_reagent("poo", 20)
				to_chat(user, "<span class='notice'>You take a peaceful dump into the bucket.</span>")
				playsound(user, shiddsound, 30, 1, 5)
				return

		for(var/mob/living/M in get_turf(user))
			if(M == user)
				continue
			else
				M.apply_damage(10,"brute","chest")
				user.log_message("pooped on [key_name(M)]", LOG_ATTACK)
				user.visible_message("<span class='warning'><b>[user]</b> poops on <b>[M]</b>!</span>", "<span class='warning'>You poop on <b>[M]</b>!</span>")

				if(ishuman(M))
					var/mob/living/carbon/human/H = M
					if(!H.shidded) // one layer at a time
						H.add_overlay(shiddoverlay)
						H.shidded = TRUE

		message = pick(	"fards and shids.",
						"makes a poo poo!",
						"fires the rear guns.",
						"composts.",
						"fertrilizes the station!",
						"opens the cargo hold.",
						"carpet bombs.",
						"bombs the floor.",
						"plants some corn.",
						"releases the barbarians at the gate.",
						"builds a dookie castle!",
						"downloads some brownware.",
						"draws mud.",
						"makes room for lunch.",
						"voids the bowels.",
						"releases a boulder.")

		new/obj/effect/decal/cleanable/poopdecal/pellets(user.loc)
		playsound(user, shiddsound, 50, 1, 5)
		user.visible_message("<b>[user]</b> [message]")
