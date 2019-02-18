//Contains the chemicals and recipes for
//the prestigious Poo Poo Pee system.
//Made by woross with love.

/datum/reagent/poo
	name = "Poo"
	id = "poo"
	description = "Very disgusting and toxic."
	color = "#663300" //Darker brown
	reagent_state = SOLID
	taste_description = "poo"
	taste_mult = 3.5
	var/tox = 0.8 //Using a var in case we add further poo chemicals...

/datum/reagent/poo/on_mob_life(mob/living/carbon/M)
	if(tox)
		M.adjustToxLoss(tox*REM, 0)
		. = TRUE
	..()

/datum/reagent/poo/reaction_turf(turf/T, reac_volume)
	if(reac_volume >= 10)
		if(!isspaceturf(T))
			//var/obj/effect/decal/cleanable/poopsplash/GG = locate() in T.contents
			//if(!GG)
			new/obj/effect/decal/cleanable/poopsplash(T)
		//	GG.reagents.add_reagent(id, reac_volume)



/datum/reagent/pee
	name = "Pee"
	id = "pee"
	reagent_state = LIQUID
	description = "Classic yellow pee."
	color = "#ffff00" //Glowing bright yellow
	taste_description = "pee"
	taste_mult = 2.5

/datum/reagent/pee/reaction_turf(turf/T, reac_volume)
	if(reac_volume >= 10)
		if(!isspaceturf(T))
			//var/obj/effect/decal/cleanable/peepuddle/GG = locate() in T.contents
			//if(!GG)
			//	GG =
			new/obj/effect/decal/cleanable/peepuddle(T)
		//	GG.reagents.add_reagent(id, reac_volume)


//JENKEM
//WELCOME TO GROSSTOWN
/datum/reagent/drug/jenkem
	name = "Jenkem"
	id = "jenkem"
	description = "The most ghetto drug you could imagine."
	color = "#996600" //A disgusting diarrhea-light brown.
	taste_description = "fermented diarrhea"
	reagent_state = LIQUID
	trippy = TRUE //:pepegrim:
	overdose_threshold = 40
	addiction_threshold = 20 //Probably gonna change these values eventually.


/datum/reagent/drug/jenkem/on_mob_life(mob/living/carbon/M)
	M.set_drugginess(10)
	M.hallucination += 10

	M.AdjustStun(-20, FALSE)
	M.AdjustKnockdown(-20, FALSE)
	M.AdjustUnconscious(-20, FALSE)
	M.AdjustParalyzed(-20, FALSE)
	M.AdjustImmobilized(-20, FALSE)
	M.adjustStaminaLoss(-2, 0)
	M.Jitter(10)

	M.adjustToxLoss(0.5*REM, 0)
	M.adjustBrainLoss(0.5*REM)

	if(prob(5))
		M.emote(pick("scream","pee","twitch","drool","poop"))
	return ..()


/datum/reagent/drug/jenkem/overdose_process(mob/living/M) //TODO: If it forces you to pee, it should reset the pee timer.
	M.adjustBrainLoss(5*REM)
	M.adjustToxLoss(5*REM, 0)
	..()
	. = 1

/datum/reagent/drug/jenkem/addiction_act_stage1(mob/living/M)
	M.Jitter(15)
	if(prob(20))
		M.emote(pick("pee","drool","moan"))
	..()

/datum/reagent/drug/jenkem/addiction_act_stage2(mob/living/M)
	M.Jitter(20)
	M.adjustBrainLoss(10)
	if(prob(30))
		M.emote(pick("poop","drool","pee"))
	..()

/datum/reagent/drug/jenkem/addiction_act_stage3(mob/living/M)
	M.Jitter(40)
	M.Dizzy(30)
	M.hallucination += 30
	if(prob(40))
		M.emote(pick("scream","poop","pee"))
	..()

/datum/reagent/drug/jenkem/addiction_act_stage4(mob/living/M)
	M.Jitter(60)
	M.Dizzy(60)
	M.hallucination += 50 //This is absolutely extreme but that's what you get for doing poo drugs bruh
	if(prob(60))
		M.emote(pick("scream","poop","pee","fart"))
	..()
	. = 1

/datum/chemical_reaction/jenkem
	name = "Jenkem"
	id = "jenkem"
	results = list("jenkem" = 2)
	required_reagents = list("poo" = 2, "pee" = 1)
	mix_message = "The mixture starts bubbling. You are overwhelmed by an ungodly stench."
	required_temp = 373

