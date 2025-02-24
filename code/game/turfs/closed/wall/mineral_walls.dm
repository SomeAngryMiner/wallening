/turf/closed/wall/mineral
	name = "mineral wall"
	desc = "This shouldn't exist"
	smoothing_flags = SMOOTH_BITMASK
	rcd_memory = null
	material_flags = MATERIAL_EFFECTS

/turf/closed/wall/mineral/gold
	name = "gold wall"
	desc = "A wall with gold plating. Swag!"
	icon = 'icons/turf/walls/gold_wall.dmi'
	sheet_type = /obj/item/stack/sheet/mineral/gold
	hardness = 65 //gold is soft
	explosive_resistance = 0 //gold is a soft metal you dingus.
	smoothing_groups = SMOOTH_GROUP_GOLD_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_GOLD_WALLS
	custom_materials = list(/datum/material/gold = SHEET_MATERIAL_AMOUNT*2)

/turf/closed/wall/mineral/silver
	name = "silver wall"
	desc = "A wall with silver plating. Shiny!"
	icon = 'icons/turf/walls/silver_wall.dmi'
	sheet_type = /obj/item/stack/sheet/mineral/silver
	hardness = 65 //silver is also soft according to moh's scale
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_SILVER_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_SILVER_WALLS
	custom_materials = list(/datum/material/silver = SHEET_MATERIAL_AMOUNT*2)

/turf/closed/wall/mineral/diamond
	name = "diamond wall"
	desc = "A wall with diamond plating. You monster."
	icon = 'icons/turf/walls/diamond_wall.dmi'
	sheet_type = /obj/item/stack/sheet/mineral/diamond
	hardness = 5 //diamond is very hard
	slicing_duration = 200   //diamond wall takes twice as much time to slice
	explosive_resistance = 3
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_DIAMOND_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_DIAMOND_WALLS
	custom_materials = list(/datum/material/diamond = SHEET_MATERIAL_AMOUNT*2)

/turf/closed/wall/mineral/diamond/hulk_recoil(obj/item/bodypart/arm, mob/living/carbon/human/hulkman, damage = 41)
	return ..()

/turf/closed/wall/mineral/bananium
	name = "bananium wall"
	desc = "A wall with bananium plating. Honk!"
	icon = 'icons/turf/walls/bananium_wall.dmi'
	sheet_type = /obj/item/stack/sheet/mineral/bananium
	hardness = 70 //it's banana
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_BANANIUM_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_BANANIUM_WALLS
	custom_materials = list(/datum/material/bananium = SHEET_MATERIAL_AMOUNT*2)

/turf/closed/wall/mineral/sandstone
	name = "sandstone wall"
	desc = "A wall with sandstone plating. Rough."
	icon = 'icons/turf/walls/sandstone_wall.dmi'
	sheet_type = /obj/item/stack/sheet/mineral/sandstone
	hardness = 50 //moh says this is apparently 6-7 on it's scale
	explosive_resistance = 0
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_SANDSTONE_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_SANDSTONE_WALLS
	custom_materials = list(/datum/material/sandstone = SHEET_MATERIAL_AMOUNT*2)

/turf/closed/wall/mineral/uranium
	article = "a"
	name = "uranium wall"
	desc = "A wall with uranium plating. This is probably a bad idea."
	icon = 'icons/turf/walls/uranium_wall.dmi'
	sheet_type = /obj/item/stack/sheet/mineral/uranium
	hardness = 40 //uranium is a 6 on moh's scale
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_URANIUM_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_URANIUM_WALLS
	custom_materials = list(/datum/material/uranium = SHEET_MATERIAL_AMOUNT*2)

	/// Mutex to prevent infinite recursion when propagating radiation pulses
	var/active = null

	/// The last time a radiation pulse was performed
	var/last_event = 0

/turf/closed/wall/mineral/uranium/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_PROPAGATE_RAD_PULSE, PROC_REF(radiate))

/turf/closed/wall/mineral/uranium/proc/radiate()
	SIGNAL_HANDLER
	if(active)
		return
	if(world.time <= last_event + 1.5 SECONDS)
		return
	active = TRUE
	radiation_pulse(
		src,
		max_range = 3,
		threshold = RAD_LIGHT_INSULATION,
		chance = URANIUM_IRRADIATION_CHANCE,
		minimum_exposure_time = URANIUM_RADIATION_MINIMUM_EXPOSURE_TIME,
	)
	propagate_radiation_pulse()
	last_event = world.time
	active = FALSE

/turf/closed/wall/mineral/uranium/attack_hand(mob/user, list/modifiers)
	radiate()
	return ..()

/turf/closed/wall/mineral/uranium/attackby(obj/item/W, mob/user, params)
	radiate()
	return ..()

/turf/closed/wall/mineral/uranium/Bumped(atom/movable/AM)
	radiate()
	return ..()

/turf/closed/wall/mineral/uranium/hulk_recoil(obj/item/bodypart/arm, mob/living/carbon/human/hulkman, damage = 41)
	return ..()

/turf/closed/wall/mineral/plasma
	name = "plasma wall"
	desc = "A wall with plasma plating. This is definitely a bad idea."
	icon = 'icons/turf/walls/plasma_wall.dmi'
	sheet_type = /obj/item/stack/sheet/mineral/plasma
	hardness = 70 // I'll tentatively compare it to Bismuth
	thermal_conductivity = 0.04
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_PLASMA_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_PLASMA_WALLS
	custom_materials = list(/datum/material/plasma = SHEET_MATERIAL_AMOUNT*2)

/turf/closed/wall/mineral/wood
	name = "wooden wall"
	desc = "A wall with wooden plating. Stiff."
	icon = 'icons/turf/walls/wood_wall.dmi'
	sheet_type = /obj/item/stack/sheet/mineral/wood
	hardness = 80
	turf_flags = IS_SOLID
	explosive_resistance = 0
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_WOOD_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_WOOD_WALLS
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT*2)

/turf/closed/wall/mineral/wood/attackby(obj/item/W, mob/user)
	if(W.get_sharpness() && W.force)
		var/duration = ((4.8 SECONDS)/W.force) * 2 //In seconds, for now.
		if(istype(W, /obj/item/hatchet) || istype(W, /obj/item/fireaxe))
			duration /= 4 //Much better with hatchets and axes.
		if(do_after(user, duration * (1 SECONDS), target=src)) //Into deciseconds.
			dismantle_wall(FALSE,FALSE)
			return
	return ..()

/turf/closed/wall/mineral/hulk_recoil(obj/item/bodypart/arm, mob/living/carbon/human/hulkman, damage = 0)
	return ..() //No recoil damage, wood is weak

/turf/closed/wall/mineral/wood/nonmetal
	desc = "A solidly wooden wall. It's a bit weaker than a wall made with metal."
	girder_type = /obj/structure/barricade/wooden
	hardness = 67 //a bit weaker than iron (60)

/turf/closed/wall/mineral/bamboo
	name = "bamboo wall"
	desc = "A wall with a bamboo finish."
	icon = 'icons/turf/walls/bamboo_wall.dmi'
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_WALLS + SMOOTH_GROUP_BAMBOO_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_BAMBOO_WALLS
	sheet_type = /obj/item/stack/sheet/mineral/bamboo
	hardness = 80 //it's not a mineral...

/turf/closed/wall/mineral/iron
	name = "rough iron wall"
	desc = "A wall with rough iron plating."
	icon = 'icons/turf/walls/iron_wall.dmi'
	sheet_type = /obj/item/stack/rods
	hardness = 60
	sheet_amount = 5
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_IRON_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_IRON_WALLS
	custom_materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5)

/turf/closed/wall/mineral/snow
	name = "packed snow wall"
	desc = "A wall made of densely packed snow blocks."
	icon = 'icons/turf/walls/snow_wall.dmi'
	smoothing_flags = SMOOTH_BITMASK
	hardness = 80
	explosive_resistance = 0
	slicing_duration = 30
	sheet_type = /obj/item/stack/sheet/mineral/snow
	smoothing_groups = SMOOTH_GROUP_SNOW_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_SNOW_WALLS
	girder_type = null
	bullet_sizzle = TRUE
	bullet_bounce_sound = null
	custom_materials = list(/datum/material/snow = SHEET_MATERIAL_AMOUNT*2)

/turf/closed/wall/mineral/snow/hulk_recoil(obj/item/bodypart/arm, mob/living/carbon/human/hulkman, damage = 0)
	return ..() //No recoil damage, snow is weak

/turf/closed/wall/mineral/abductor
	name = "alien wall"
	desc = "A wall with alien alloy plating."
	icon = 'icons/turf/walls/abductor_wall.dmi'
	sheet_type = /obj/item/stack/sheet/mineral/abductor
	hardness = 10
	slicing_duration = 200   //alien wall takes twice as much time to slice
	explosive_resistance = 3
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_DIAGONAL_CORNERS
	smoothing_groups = SMOOTH_GROUP_ABDUCTOR_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_ABDUCTOR_WALLS
	custom_materials = list(/datum/material/alloy/alien = SHEET_MATERIAL_AMOUNT*2)

/turf/closed/wall/mineral/meat
	name = "meat wall"
	desc = "A wall of somone's compacted meat."
	icon = 'icons/turf/walls/meat_wall.dmi'
	sheet_type = /obj/item/stack/sheet/meat
	hardness = 50
	explosive_resistance = 0
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_MEAT_WALLS + SMOOTH_GROUP_CLOSED_TURFS + SMOOTH_GROUP_WALLS
	canSmoothWith = SMOOTH_GROUP_MEAT_WALLS
	custom_materials = list(/datum/material/meat = 4000)

/////////////////////Titanium walls/////////////////////

/turf/closed/wall/mineral/titanium //has to use this path due to how building walls works
	name = "wall"
	desc = "A light-weight titanium wall used in shuttles."
	icon = 'icons/turf/walls/shuttle_wall.dmi'
	explosive_resistance = 3
	flags_1 = CAN_BE_DIRTY_1
	flags_ricochet = RICOCHET_SHINY | RICOCHET_HARD
	sheet_type = /obj/item/stack/sheet/mineral/titanium
	hardness = 40 //6 on moh's scale
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_TITANIUM_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_SHUTTLE_PARTS + SMOOTH_GROUP_TITANIUM_WALLS
	custom_materials = list(/datum/material/titanium = SHEET_MATERIAL_AMOUNT*2)

/turf/closed/wall/mineral/titanium/rust_heretic_act()
	return // titanium does not rust

/turf/closed/wall/mineral/titanium/nodiagonal
	smoothing_flags = SMOOTH_BITMASK

/turf/closed/wall/mineral/titanium/overspace
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_DIAGONAL_CORNERS
	fixed_underlay = list("space" = TRUE)

/turf/closed/wall/mineral/titanium/interior/copyTurf(turf/T)
	. = ..()
	T.transform = transform

/turf/closed/wall/mineral/titanium/copyTurf(turf/T)
	. = ..()
	T.transform = transform

/turf/closed/wall/mineral/titanium/survival
	name = "pod wall"
	desc = "An easily-compressable wall used for temporary shelter."
	icon = 'icons/turf/walls/survival_pod_wall.dmi'
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_DIAGONAL_CORNERS
	canSmoothWith = SMOOTH_GROUP_SHUTTLE_PARTS + SMOOTH_GROUP_AIRLOCK + SMOOTH_GROUP_WINDOW_FULLTILE + SMOOTH_GROUP_TITANIUM_WALLS

/turf/closed/wall/mineral/titanium/survival/nodiagonal
	icon = 'icons/turf/walls/survival_pod_wall.dmi'
	smoothing_flags = SMOOTH_BITMASK

/turf/closed/wall/mineral/titanium/survival/pod
	smoothing_groups = SMOOTH_GROUP_SURVIVAL_TITANIUM_POD + SMOOTH_GROUP_TITANIUM_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_SURVIVAL_TITANIUM_POD

/////////////////////Plastitanium walls/////////////////////

/turf/closed/wall/mineral/plastitanium
	name = "wall"
	desc = "A durable wall made of an alloy of plasma and titanium."
	icon = 'icons/turf/walls/plastitanium_wall.dmi'
	explosive_resistance = 4
	sheet_type = /obj/item/stack/sheet/mineral/plastitanium
	hardness = 25 //upgrade on titanium
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_DIAGONAL_CORNERS
	smoothing_groups = SMOOTH_GROUP_PLASTITANIUM_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_SHUTTLE_PARTS + SMOOTH_GROUP_AIRLOCK + SMOOTH_GROUP_PLASTITANIUM_WALLS + SMOOTH_GROUP_SYNDICATE_WALLS
	custom_materials = list(/datum/material/alloy/plastitanium = SHEET_MATERIAL_AMOUNT*2)

/turf/closed/wall/mineral/plastitanium/rust_heretic_act()
	return // plastitanium does not rust

/turf/closed/wall/mineral/plastitanium/nodiagonal
	smoothing_flags = SMOOTH_BITMASK

/turf/closed/wall/mineral/plastitanium/overspace
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_DIAGONAL_CORNERS
	fixed_underlay = list("space" = TRUE)


/turf/closed/wall/mineral/plastitanium/explosive/ex_act(severity)
	var/obj/item/bombcore/large/bombcore = new(get_turf(src))
	bombcore.detonate()
	return ..()

/turf/closed/wall/mineral/plastitanium/hulk_recoil(obj/item/bodypart/arm, mob/living/carbon/human/hulkman, damage = 41)
	return ..()

/turf/closed/wall/mineral/plastitanium/copyTurf(turf/T)
	. = ..()
	T.transform = transform
