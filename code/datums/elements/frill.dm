GLOBAL_LIST_EMPTY(frill_objects)


/proc/get_frill_object(icon_path, junction, alpha = 255, pixel_x = 0, pixel_y = 0, plane = FRILL_PLANE, turf/offset_spokesman)
	var/offset = GET_TURF_PLANE_OFFSET(offset_spokesman)
	. = GLOB.frill_objects["[icon_path]-[junction]-[alpha]-[pixel_x]-[pixel_y]-[plane]-[offset]"]
	if(.)
		return
	var/mutable_appearance/mut_appearance = mutable_appearance(icon_path, "frill-[junction]", ABOVE_MOB_LAYER, null, plane, alpha, offset_const = offset)
	mut_appearance.pixel_x = pixel_x
	mut_appearance.pixel_y = pixel_y
	return GLOB.frill_objects["[icon_path]-[junction]-[alpha]-[pixel_x]-[pixel_y]-[plane]-[offset]"] = mut_appearance

/**
 * Attached to smoothing atoms. Adds a globally-cached object to their vis_contents and updates based on junction changes.
 * ATTENTION: This element was supposed to be for atoms, but since only movables and turfs actually have vis_contents hacks have to be done.
 * For now it treats all of its targets as turfs, but that will runtime if an invalid variable access happens.
 * Yes, this is ugly. The alternative is making two different elements for the same purpose.
 */
/datum/element/frill
	element_flags = ELEMENT_DETACH_ON_HOST_DESTROY | ELEMENT_BESPOKE
	argument_hash_start_idx = 2
	var/icon_path


/datum/element/frill/Attach(datum/target, icon_path)
	if(!isturf(target) && !ismovable(target)) // Turfs and movables have vis_contents. Atoms don't. Pain.
		return ELEMENT_INCOMPATIBLE
	. = ..()
	src.icon_path = icon_path

	var/atom/atom_target = target

	on_junction_change(atom_target, atom_target.smoothing_junction)
	RegisterSignal(target, COMSIG_ATOM_SET_SMOOTHED_ICON_STATE, PROC_REF(on_junction_change))

/datum/element/frill/Detach(turf/target)

	target.cut_overlay(get_frill_object(icon_path, target.smoothing_junction, pixel_y = 32, offset_spokesman = target))
	target.cut_overlay(get_frill_object(icon_path, target.smoothing_junction, plane = OVER_FRILL_PLANE, pixel_y = 32, offset_spokesman = target))
	UnregisterSignal(target, COMSIG_ATOM_SET_SMOOTHED_ICON_STATE)
	return ..()


/datum/element/frill/proc/on_junction_change(atom/source, new_junction)
	SIGNAL_HANDLER
	var/turf/turf_or_movable = source
	if(!(source.smoothing_junction & NORTH))
		turf_or_movable.cut_overlay(get_frill_object(icon_path, source.smoothing_junction, pixel_y = 32, offset_spokesman = source))
	else
		turf_or_movable.cut_overlay(get_frill_object(icon_path, source.smoothing_junction, plane = OVER_FRILL_PLANE, pixel_y = 32, offset_spokesman = source))

	if(!(new_junction & NORTH))
		turf_or_movable.add_overlay(get_frill_object(icon_path, new_junction, pixel_y = 32, offset_spokesman = source))
	else
		turf_or_movable.add_overlay(get_frill_object(icon_path, new_junction, plane = OVER_FRILL_PLANE, pixel_y = 32, offset_spokesman = source))
