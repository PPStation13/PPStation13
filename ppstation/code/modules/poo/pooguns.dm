//Coded by woross
//Beautiful sprites made by Old Man
//Made with love for PP Station 13

//Poo Flintlock - the "Rump Raider"

/obj/item/gun/ballistic/poopistol
	name = "poo pistol"
	desc = "A common flintlock pistol, capable of shooting poo. Called the \"Rump Raider\" by bandits, it is very popular with space outlaws for its low cost."
	icon = 'ppstation/icons/Rump_Raider.dmi'
	icon_state = "rump_raider"
	item_state = "rump_raider"

	lefthand_file = 'ppstation/icons/poohand_left.dmi'
	righthand_file = 'ppstation/icons/poohand_right.dmi'

	w_class = WEIGHT_CLASS_NORMAL
	force = 10
	slot_flags = ITEM_SLOT_BELT
	fire_sound = 'sound/weapons/gunshot.ogg'
	var/lock = FALSE
	var/lock_sound = 'sound/weapons/gun_dry_fire.ogg'
	var/insert_sound = 'sound/weapons/gun_dry_fire.ogg'
	weapon_weight = WEAPON_MEDIUM
	spawnwithmagazine = FALSE
	casing_ejector = FALSE

/obj/item/gun/ballistic/poopistol/attackby(obj/item/A, mob/living/user, params)
	if (!chambered)
		if (lock)
			if (istype(A, /obj/item/reagent_containers/food/snacks/poo))
				chambered = new /obj/item/ammo_casing/poo
				playsound(user, insert_sound, 50, 1)
				to_chat(user, "<span class='notice'>You load the [src].</span>")
				qdel(A)
		else
			to_chat(user, "<span class='warning'>The pistol is not cocked!</span>")
	else
		to_chat(user, "<span class='warning'>There's already a [chambered.BB] loaded!<span>")
	return

/obj/item/gun/ballistic/poopistol/process_chamber(empty_chamber = 0)
	chambered = null
	lock = FALSE
	return

/obj/item/gun/ballistic/poopistol/chamber_round()
	return

/obj/item/gun/ballistic/poopistol/can_shoot()
	if (!chambered)
		return

	if (!lock)
		return

	return (chambered.BB ? 1 : 0)

/obj/item/gun/ballistic/poopistol/attack_self(mob/living/user)
	if (!chambered)
		lock = !lock
		playsound(user, lock_sound, 50, 1)
		if (lock)
			to_chat(user, "<span class='notice'>You cock the pistol.</span>")
		else
			to_chat(user, "<span class='notice'>You uncock the pistol.</span>")
	else
		to_chat(user, "<span class='warning'>You can't remove the poo once it's in!</span>")
	return

/obj/item/gun/ballistic/poopistol/examine(mob/user)
	..()
	var/examinemessage = "The pistol is "
	if (lock)
		examinemessage = examinemessage + "cocked."
	else
		examinemessage = examinemessage + "not cocked."
	to_chat(user, "[examinemessage]")

	if (chambered?.BB)
		to_chat(user, "A poo is loaded.")

//Projectiles

/obj/item/ammo_casing/poo //just virtual
	projectile_type = /obj/item/projectile/poo

/obj/item/projectile/poo
	name = "poo"
	icon = 'ppstation/icons/Rump_Raider.dmi'
	icon_state = "poojectile"
	suppressed = FALSE
	damage = 20
	range = 12
	damage_type = BRUTE
	hitsound = "desceration"
	flag = "bullet"

/obj/item/projectile/poo/on_range()
	new /obj/effect/decal/cleanable/poopsplash(get_turf(src))
	..()

/obj/item/projectile/poo/on_hit(atom/target, blocked = FALSE)
	..()
	if (istype(target, /mob))
		if (ishuman(target))
			var/mob/living/carbon/human/H = target
			var/mutable_appearance/shiddoverlay = mutable_appearance('ppstation/icons/poo.dmi')
			shiddoverlay.icon_state = "Shitoverlay"
			H.Paralyze(10)
			H.adjust_blurriness(5)
			if(!H.shidded) // one layer at a time
				H.add_overlay(shiddoverlay)
				H.shidded = TRUE
	new /obj/effect/decal/cleanable/poopsplash(get_turf(target))
	qdel(src)
