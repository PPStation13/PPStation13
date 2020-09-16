/obj/item/reagent_containers/food/snacks/poo
	name = "poo log"
	desc = "A humongous length of fecal cable."
	icon = 'ppstation/icons/poo/poo.dmi'
	bitesize = 5
	list_reagents = list("nutriment" = 5, "poo" = 10)
	tastes = list("crap" = 4)
	icon_state = "LogInhand"
	throwforce = 5 //:pepegrim:
	lefthand_file = 'ppstation/icons/poo/poohand_left.dmi'
	righthand_file = 'ppstation/icons/poo/poohand_right.dmi'

	var/poostun = TRUE
	var/poostunlength = 20
	var/pooblurlevel = 1
	foodtype = GROSS | TOXIC

/obj/item/reagent_containers/food/snacks/poo/pellets
	name = "poo"
	desc = "A small pile of poo."
	icon_state = "PelletsInHand"
	poostunlength = 10

/obj/item/reagent_containers/food/snacks/poo/liquid
	name = "liquid poo"
	desc = "Some liquid poo."
	icon_state = "RunnyInhand"

	poostun = FALSE
	pooblurlevel = 5

/obj/item/reagent_containers/food/snacks/poo/clown

	name = "rainbow poo"
	desc = "A very happy looking piece of clown poo."
	icon_state = "ClownTurdInhand"
	bonus_reagents = list("poo" = 10, "nutriment" = 10, "space_drugs" = 5)
	throwforce = 10 //:pepescheming:
	poostunlength = 30
	tastes = list("rainbows" = 4)
	foodtype = SUGAR


/obj/item/reagent_containers/food/snacks/poo/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(!.)
		splat(hit_atom)

/obj/item/reagent_containers/food/snacks/poo/proc/splat(atom/movable/hit_atom)

	//Grabbing pie code for this... No need to reinvent the wheel...
	if(isliving(loc))
		return
	var/turf/T = get_turf(hit_atom)
	new/obj/effect/decal/cleanable/poopsplash(T)
	if(reagents && reagents.total_volume)
		reagents.reaction(hit_atom, TOUCH)

	if(ishuman(hit_atom))
		var/mob/living/carbon/human/H = hit_atom
		var/mutable_appearance/shiddoverlay = mutable_appearance('ppstation/icons/poo/poo.dmi')
		shiddoverlay.icon_state = "Shitoverlay"
		if(poostun)
			H.Paralyze(poostunlength)
		H.adjust_blurriness(pooblurlevel)
		H.visible_message("<span class='warning'>[H] got splatted by [src]!</span>", "<span class='userdanger'>You've been splatted by [src]!</span>")
		playsound(H, "desceration", 50, TRUE)
		if(!H.shidded) // one layer at a time
			H.add_overlay(shiddoverlay)
			H.shidded = TRUE
			//TODO: handle it in moods
			//SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "creampie", /datum/mood_event/creampie)
	qdel(src)
