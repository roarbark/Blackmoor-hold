/obj/effect/proc_holder/spell/targeted/wildshape
	name = "Beast Form"
	desc = "Take on the form of one of Dendor's sacred beasts."
	overlay_state = "tamebeast"
	clothes_req = FALSE
	human_req = FALSE
	range = -1
	include_user = TRUE
	releasedrain = 60
	recharge_time = 30 SECONDS
	cooldown_min = 50
	invocation = "Treefather grant me your form!"
	invocation_type = "shout"
	action_icon_state = "shapeshift"
	associated_skill = /datum/skill/magic/holy
	devotion_cost = 80
	miracle = TRUE
	clothes_req = FALSE
	human_req = FALSE

	die_with_shapeshifted_form =  FALSE
	pick_again = TRUE


	var/pick_again = null
	var/list/possible_shapes = list(
		/mob/living/carbon/human/species/wildshape/volf
	)

/obj/effect/proc_holder/spell/targeted/wildshape/cast(list/targets, mob/user = usr)
	. = ..()
	if(!istype(usr, /mob/living/carbon/human/species/wildshape)) //If we aren't a wildshaped species, we can use this
		var/list/animal_list = list()
		for(var/path in possible_shapes)
			var/mob/living/carbon/human/species/wildshape/A = path
			animal_list[initial(A.name)] = path
		var/new_wildshape_type = input(M, "Choose Your Animal Form!", "It's Morphing Time!", null) as null|anything in sortList(animal_list)
		usr.wildshape_transformation(new_wildshape_type)

	else //If we are a wildshaped species, we simply un-transform
		usr.wildshape_untransform()

	return

// Mob itself
/mob/living/carbon/human/species/wildshape

/mob/living/carbon/human/species/wildshape/proc/gain_inherent_skills()
