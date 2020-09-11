/obj/item/gun/ballistic/grinder_gun
	name = "grinder gun"
	desc = "A simple gun characterized by its large grinder with a crank that simultaneously grinds rocks and compresses air, allowing the gun to shoot gravel. Laughably weak beyond close range."
	icon = 'ppstation/icons/ballistic_guns.dmi'
	icon_state = "rock_pistol"
	//item_state = "rock_pistol" no custom inhand yet, do we even need one?
	var/grind_sound = 'ppstation/sound/gravel.ogg'
	var/grinding = FALSE
	var/rocks_loaded = FALSE
	var/ammo_left = 0
	weapon_weight = WEAPON_MEDIUM
	spawnwithmagazine = FALSE
	casing_ejector = FALSE

/obj/item/gun/ballistic/grinder_gun/can_shoot()
	if (!chambered)
		return

	if (grinding)
		return

	return (chambered.BB ? 1 : 0)

/obj/item/gun/ballistic/grinder_gun/get_ammo()
	return ammo_left

/obj/item/gun/ballistic/grinder_gun/attack_self(mob/living/user)
	if (grinding)
		return
	else
		if (chambered)
			to_chat(user, "<span class='warning'>No point in grinding any further.</span>")
		else
			if (rocks_loaded)
				icon_state = "rock_pistol-spin"
				grinding = TRUE
				playsound(user, grind_sound, 75, 1)
				if(!do_mob(user, user, 30))
					icon_state = "rock_pistol"
					grinding = FALSE
					to_chat(user, "<span class='warning'>Your grinding was interrupted.</span>")
					return
				rocks_loaded = FALSE
				grinding = FALSE
				icon_state = "rock_pistol"
				ammo_left = 3
				chambered = new /obj/item/ammo_casing/shotgun/grinder_gun
				playsound(user, 'sound/weapons/bulletinsert.ogg', 50, 1)
			else
				to_chat(user, "<span class='warning'>Nothing to grind.</span>")
	return

/obj/item/ammo_casing/shotgun/grinder_gun //just virtual.
	name = "grinder shell"
	desc = "How did you even get this?"
	projectile_type = /obj/item/projectile/bullet/pellet/grinder_gun
	pellets = 12
	variance = 35

/obj/item/projectile/bullet/pellet/grinder_gun
	name = "pebble"
	icon = 'ppstation/icons/projectiles.dmi'
	speed = 0.8
	range = 6
	damage = 3
	stamina = 2
/obj/item/projectile/bullet/pellet/grinder_gun/Initialize()
	..()
	icon_state = "gravel[rand(1, 6)]"

/obj/item/gun/ballistic/grinder_gun/process_chamber(empty_chamber = 0)
	chambered = null
	ammo_left -= 1
	if(ammo_left)
		chambered = new /obj/item/ammo_casing/shotgun/grinder_gun
