extends "res://goap/Action.gd"

signal awake

var target = null

func reset() -> void:
	target = null

func execute(delta : float) -> void:
	if target == null and goap.world.get_node("House"):
		target = goap.world.get_node("House")
		goap.fsm.target = target.position
	elif target and goap.world.get_node("House"):
		if !goap.fsm.is_in_range:
			goap.fsm.move()
		elif goap.condition_state["sleep"] == false:
			goap.condition_state["sleep"] = true
			goap.fsm.pop_state()
			$Timer.start()
	else:
		emit_signal("canceled")

func _setpt_up_preconditions() -> void:
	preconditions["has_iron"] = false
	preconditions["has_axe"] = false

func _setpt_up_effects() -> void:
	effects["sleep"] = true


func _on_Timer_timeout() -> void:
	goap.condition_state["sleep"] = false
	goap.pop_action()
	emit_signal("awake")
