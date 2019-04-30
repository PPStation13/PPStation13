// PP Station 13 Hobo Module
// Coded by woross, beautiful sprites hand drawn by Old Man
// Contains hobo clothes and the job itself


//
// HOBO CLOTHES
//


/obj/item/clothing/under/hobo
	alternate_worn_icon = 'ppstation/icons/HoboClothes.dmi'
	icon = 'ppstation/icons/HoboClothes.dmi'
	name = "rags"
	desc = "Disgusting hobo rags."
	icon_state = "Hobo1"
	item_state = "Hobo"
	item_color = "Hobo"
	can_adjust = 0
//
// HOBO JOB
//

/obj/effect/landmark/start/hobo
	name = "Hobo"
	icon = 'ppstation/icons/HoboClothes.dmi'
	icon_state = "hobospawn"


/datum/job/hobo
	title = "Hobo"
	flag = HOBO
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 10
	spawn_positions = 0
	supervisors = "absolutely everyone, but there's no chance in hell that anyone would actually get you to do anything"
	selection_color = "#cccccc"
	access = list() //LOL!
	minimal_access = list()
	outfit = /datum/outfit/job/hobo
	antag_rep = 7
	paycheck = PAYCHECK_ASSISTANT // lol lol lol
	paycheck_department = ACCOUNT_CIV //lmao

/datum/outfit/job/hobo
	name = "Hobo"
	jobtype = /datum/job/hobo
	ears = /obj/item/radio/headset
	uniform =  /obj/item/clothing/under/hobo
	shoes = /obj/item/clothing/shoes/sandal

	id = null //gottem!
	backpack = null
	belt = null

/datum/job/hobo/after_spawn(mob/living/carbon/human/H, mob/M)

	var/suit=null
	var/back=null
	var/belt=null
	var/gloves=null
	var/shoes=null
	var/head=null
	var/mask="/obj/item/clothing/mask/cigarette"
	var/neck=null
	var/glasses=null
	var/l_hand=null
	var/r_hand=null
	var/l_pocket="/obj/item/lighter/greyscale"
	var/r_pocket=null

	if(prob(20))
		suit = pick("/obj/item/clothing/suit/hooded/wintercoat",
					"/obj/item/clothing/suit/armor/makeshift",
					"/obj/item/clothing/suit/armor/vest",
					"/obj/item/clothing/suit/hazardvest",
				// 	"/obj/item/clothing/suit/nerdshirt", these are too damn ugly
				//	"/obj/item/clothing/suit/vapeshirt",
					"/obj/item/clothing/suit/jacket")

	if(prob(20))
		head = pick("/obj/item/clothing/head/foilhat", //pepegrim
					"/obj/item/clothing/head/helmet/roman",
					"/obj/item/clothing/head/helmet/larp",
					"/obj/item/clothing/head/pp/horn_helmet",
					"/obj/item/clothing/head/pp/oldbeanie",
					"/obj/item/clothing/head/fedora",
					"/obj/item/clothing/head/pp/edwin," //Awes!
					"/obj/item/clothing/head/flatcap",
					"/obj/item/clothing/head/bandana",
					"/obj/item/clothing/head/cone",
					"/obj/item/clothing/head/jester")

	if(prob(10))
		belt = pick("/obj/item/grenade/smokebomb",
					"/obj/item/gun/ballistic/poopistol",
					"/obj/item/grenade/chem_grenade/cleaner",
					"/obj/item/grenade/chem_grenade/glitter/pink",
					"/obj/item/storage/belt/utility",
					"/obj/item/storage/belt/military/snack",
					"/obj/item/grenade/plastic/c4") //lol why not

	if(prob(20))
		back = pick("/obj/item/storage/backpack/satchel/leather",
					"/obj/item/storage/backpack")

	if(prob(20))
		mask = pick("/obj/item/clothing/mask/balaclava",
					"/obj/item/clothing/mask/cigarette/rollie/trippy",
					"/obj/item/clothing/mask/cigarette/rollie/mindbreaker",
					"/obj/item/clothing/mask/cigarette/rollie/cannabis")

	if(prob(35))
		gloves=pick("/obj/item/clothing/gloves/color/black",
					"/obj/item/clothing/gloves/fingerless")

	if(prob(20))
		l_pocket=pick("/obj/item/lighter",
				      "/obj/item/storage/box/matches")
	if(prob(10))
		neck = pick("/obj/item/clothing/neck/tie/borrible",
					"/obj/item/clothing/neck/scarf")

	r_pocket=pick("/obj/item/melee/shank",
				  "/obj/item/reagent_containers/pill/jenkem",
				  "/obj/item/storage/pill_bottle/jenkem",
				  "/obj/item/reagent_containers/food/drinks/beer",
				  "/obj/item/reagent_containers/food/drinks/bottle/vodka",
				  "/obj/item/reagent_containers/food/drinks/bottle/whiskey",
				  "/obj/item/reagent_containers/food/drinks/bottle/wine",
				  "/obj/item/reagent_containers/food/snacks/poo",
				  "/obj/item/reagent_containers/food/snacks/grown/cabbage",
				  "/obj/item/reagent_containers/food/snacks/grown/potato",
				  "/obj/item/reagent_containers/food/snacks/grown/tomato",
				  "/obj/item/reagent_containers/syringe",
				  "/obj/item/switchblade",
				  "/obj/item/shovel/spade",
				  "/obj/item/toy/crayon/spraycan",
				  "/obj/item/gun/ballistic/shotgun/toy/crossbow",
				  "/obj/item/gun/ballistic/automatic/toy/pistol/riot",
				  "/obj/item/toy/cards/deck",
				  "/obj/item/crowbar",
				  "/obj/item/wrench",
				  "/obj/item/screwdriver")

	if(prob(50))
		l_hand=pick("/obj/item/hatchet/improvised",
					"/obj/item/hatchet",
					"/obj/item/extinguisher",
					"/obj/item/reagent_containers/food/snacks/poo",
					"/obj/item/reagent_containers/food/snacks/poo/clown",
					"/obj/item/storage/toolbox/mechanical",
					"/obj/item/storage/toolbox/emergency",
					"/obj/item/reagent_containers/spray/plantbgone",
					"/obj/item/soap/homemade",
					"/obj/item/gun/ballistic/crossbow/improv",
					"/obj/item/stack/sheet/mineral/wood/fifty",
					"/obj/item/pickaxe",
					"/obj/item/storage/bag/tray",
					"/obj/item/shield/trayshield",
					"/obj/item/reagent_containers/glass/bottle/toxin",
					"/obj/item/reagent_containers/food/drinks/bottle/absinthe",
					"/obj/item/reagent_containers/food/drinks/bottle/vodka",
					"/obj/item/reagent_containers/food/drinks/bottle/whiskey",
					"/obj/item/reagent_containers/food/drinks/bottle/wine",
					"/obj/item/reagent_containers/glass/beaker/waterbottle/large",
					"/obj/item/stack/rods/twentyfive",
					"/obj/item/a_gift",
					"/obj/item/reagent_containers/food/snacks/chips",
					"/obj/item/reagent_containers/glass/bucket/poo",
					"/obj/item/reagent_containers/glass/bucket/pee")
	if(prob(20))
		r_hand=pick("/obj/item/reagent_containers/food/drinks/bottle/vodka",
					"/obj/item/reagent_containers/food/drinks/bottle/whiskey",
					"/obj/item/reagent_containers/food/drinks/bottle/wine")

	if(suit)
		H.equip_to_slot_or_del(new suit(H),SLOT_WEAR_SUIT)
	if(back)
		H.equip_to_slot_or_del(new back(H),SLOT_BACK)
	if(belt)
		H.equip_to_slot_or_del(new belt(H),SLOT_BELT)
	if(gloves)
		H.equip_to_slot_or_del(new gloves(H),SLOT_GLOVES)
	if(shoes)
		H.equip_to_slot_or_del(new shoes(H),SLOT_SHOES)
	if(head)
		H.equip_to_slot_or_del(new head(H),SLOT_HEAD)
	if(mask)
		H.equip_to_slot_or_del(new mask(H),SLOT_WEAR_MASK)
	if(neck)
		H.equip_to_slot_or_del(new neck(H),SLOT_NECK)
	if(glasses)
		H.equip_to_slot_or_del(new glasses(H),SLOT_GLASSES)
	if(l_hand)
		H.put_in_l_hand(new l_hand(H))
	if(r_hand)
		H.put_in_r_hand(new r_hand(H))
	if(l_pocket)
		H.equip_to_slot_or_del(new l_pocket(H),SLOT_L_STORE)
	if(r_pocket)
		H.equip_to_slot_or_del(new r_pocket(H),SLOT_R_STORE)