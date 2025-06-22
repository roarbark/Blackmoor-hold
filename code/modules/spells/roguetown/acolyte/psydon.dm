// PSY'S TRUTH IS BLINDING

/obj/effect/proc_holder/spell/invoked/elucidate
	name = "Elucidate"
	desc = "The Agonizing Truth of the Martyr causes a temporary seizure of the senses."
	recharge_time = 15 SECONDS
	movement_interrupt = FALSE
	chargedrain = 0
	chargetime = 5 SECONDS
	associated_skill = /datum/skill/magic/holy
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	sound = 'sound/magic/antimagic.ogg'
	invocation = "PSYDON! UNVEIL THE TRUTH!"
	invocation_type = "shout"
	miracle = TRUE
	antimagic_allowed = TRUE
	devotion_cost = 10

/obj/effect/proc_holder/spell/invoked/elucidate/cast(list/targets, mob/user = usr)
	var/list/sounds = list(
		'sound/villain/hall_attack1.ogg',
		'sound/villain/hall_attack2.ogg',
		'sound/villain/hall_attack3.ogg',
		'sound/villain/hall_attack4.ogg',
	)
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(target.anti_magic_check(TRUE, TRUE))
			return FALSE
		if(target.patron != /datum/patron/old_god) //We don't target our brothers
			return FALSE
		target.visible_message(span_warning("[user] elucidates [target]!"),span_warning("I HAVE BEEN ILLUMINATED!"))
		target.playsound_local(target, pick(sounds), vol = 100, vary = FALSE)
		if(alert(target, "Do you accept the Truth of PSYDON?", "JUDGEMENT", "Yes", "No") == "Yes")
			target.patron = /datum/patron/old_god
		return TRUE
	revert_cast()
	return FALSE



/datum/status_effect/elucidated
	id = "elucidated"
	alert_type = /atom/movable/screen/alert/status_effect/elucidated
	status_type = STATUS_EFFECT_UNIQUE
	duration = 30 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/elucidated

/datum/status_effect/elucidated/on_apply()
	owner.overlay_fullscreen("elucidated", /atom/movable/screen/fullscreen/psydon)

/datum/status_effect/elucidated/on_remove()
	owner.clear_fullscreen("elucidated")


/atom/movable/screen/alert/status_effect/elucidated
	name = "TRUTH"
	desc = "No... IT CAN'T BE!"
	icon_state = "stressvb"
