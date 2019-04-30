/obj/structure/bonfire/hobobarrel

	name = "hobo barrel"
	desc = "A crude yet cozy hobo barrel used as a bonfire."
	icon = 'ppstation/icons/Barrels.dmi'
	icon_state = "barrel"
	light_color = LIGHT_COLOR_FIRE
	density = TRUE
	anchored = TRUE
	max_integrity = 6000000 //the immortal one
	can_buckle = FALSE
	burn_icon = "barrel_burning"

/obj/structure/bonfire/hobobarrel/attackby(obj/item/W, mob/user, params)
	if(W.is_hot())
		StartBurning()

/obj/structure/bonfire/hobobarrel/attack_hand(mob/user)
	if(burning)
		user.adjust_bodytemperature(user.bodytemperature + 1)
		to_chat(user, "<span class='notice'>You warm your hands on the [src].</span>")
		return

/obj/structure/bonfire/hobobarrel/Crossed(atom/movable/AM)
	if(burning)
		Burn()

/obj/structure/bonfire/hobobarrel/extinguish()
	if(burning)
		icon_state = "barrel"
		burning = 0
		set_light(0)
		STOP_PROCESSING(SSobj, src)

/obj/structure/bonfire/hobobarrel/proc/is_hot()
	return(burning)