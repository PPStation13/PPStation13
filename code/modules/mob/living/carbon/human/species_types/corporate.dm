/datum/species/corporate
	name = "Corporate Agent"
	id = "agent"
	hair_alpha = 0
	say_mod = "declares"
	speedmod = -2//Fast
	brutemod = 0.7//Tough against firearms
	burnmod = 0.65//Tough against lasers
	coldmod = 0
	heatmod = 0.5//it's a little tough to burn them to death not as hard though.
	punchdamage = 10
	attack_verb = "smash"
	attack_sound = 'sound/weapons/resonator_blast.ogg'
	blacklisted = 1
	use_skintones = 0
	species_traits = list(NOBLOOD,EYECOLOR)
	inherent_traits = list(TRAIT_RADIMMUNE,TRAIT_VIRUSIMMUNE,TRAIT_PIERCEIMMUNE,TRAIT_NODISMEMBER,TRAIT_NOLIMBDISABLE,TRAIT_NOHUNGER)
	sexes = 0