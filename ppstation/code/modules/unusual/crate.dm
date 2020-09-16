/obj/structure/unusual_crate
	name = "titanium crate"
	desc = "A hardened titanium crate reinforced with plasteel plates and rods, coated with polished digital honeycomb resin. It is estimated that getting into this crate by force would take approximately four hundred years."
	icon = 'ppstation/icons/crate.dmi'
	icon_state = "random"
	resistance_flags = INDESTRUCTIBLE
	var/locked = FALSE
	var/crate_type = "random"

/obj/structure/unusual_crate/examine(mob/user)
	..()
	if (locked)
		to_chat(user, "It is secured by a self-sustained electromagnetic field further protected by high-powered lasers, the generator of which is locked behind a warded sixteen-disc detainer lock, considered by most people impossible to pick within the lifespan of a human.")
	else
		to_chat(user, "It is unlocked.")

/obj/structure/unusual_crate/attack_hand(mob/living/user)
	if (locked)
		to_chat(user, "<span class='warning'>It's locked!</span>")
		return
	else
		var/generate = generate_random_unusual_hat()
		var/obj/item/new_hat = generate
		user.put_in_hands(new_hat)
		return