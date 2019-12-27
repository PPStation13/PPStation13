/area/sewers
	name = "Sewers"
	icon_state = "yellow"
	dynamic_lighting = DYNAMIC_LIGHTING_FORCED
	requires_power = FALSE
	has_gravity = STANDARD_GRAVITY
	noteleport = TRUE
	flags_1 = NONE

/turf/open/indestructible/dirt
	name = "dirt"
	desc = "Upon closer examination, it's still dirt."
	icon_state = "dirt"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = FALSE
	intact = FALSE

/turf/open/sewer_water
	gender = PLURAL
	flags_1 = 0
	name = "toxic water"
	desc = "Please, do not drink this."
	icon = 'icons/turf/floors.dmi'
	icon_state = "riverwater_motion"
	baseturfs = /turf/open/indestructible/dirt
	planetary_atmos = TRUE
	slowdown = 1
	bullet_sizzle = TRUE
	bullet_bounce_sound = null //needs a splashing sound one day.
	footstep = FOOTSTEP_WATER
	barefootstep = FOOTSTEP_WATER
	clawfootstep = FOOTSTEP_WATER
	heavyfootstep = FOOTSTEP_WATER

/turf/open/sewer_water/Entered(atom/movable/AM)
	if(isliving(AM))
		var/mob/living/live = AM
		if(!("lava" in live.weather_immunities))
			live.acid_act(15, 15)
			live.apply_damage(10, BURN)
			live.say("*scream")
	else
		AM.acid_act(15, 15)

/turf/closed/indestructible/dryrock
	icon= 'icons/turf/mining.dmi'
	name = "rock"
	icon_state="rock2"


/turf/closed/indestructible/wateryrock
	icon= 'icons/turf/mining.dmi'
	name = "wet rock"
	icon_state="wateryrock"

/turf/closed/indestructible/wateryrock/Initialize()
	icon_state = "[icon_state][rand(1, 9)]"
	. = ..()
