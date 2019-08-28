/*

PP Station 13 - Jewish Trinkets!
Made with love by woross

*/

/obj/item/dreidel
	name = "dreidel"
	desc = "A fun wooden toy."
	icon = 'ppstation/icons/dreidel.dmi'
	icon_state = "shin"
	w_class = WEIGHT_CLASS_TINY
	var/states = list("shin","he","gimel","nun")
	var/roll = 1
	var/spinning = 0

/obj/item/dreidel/attack_self(mob/user)
	if(!spinning)
		spinning = 1
		icon_state = "spin"
		sleep(5)
		roll = rand(1, 4)
		icon_state = states[roll]
		user.visible_message("[user] spins [src]. It lands on [states[roll]].", \
		"<span class='notice'>You spin [src]. It lands on [states[roll]].</span>")
		spinning  = 0

/obj/item/candle/infinite/menorah
	name = "menorah"
	desc = "Oy vey!"
	icon = 'ppstation/icons/jew.dmi'
	icon_state = "menorah"
	item_state = null

/obj/item/candle/infinite/menorah/update_icon()
	icon_state = "menorah[lit ? "_lit" : ""]"