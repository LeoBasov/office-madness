extends "res://goap/Action.gd"

var target = null
var walk_state

func reset() -> void:
	target = null
	walk_state = goap.fsm.get_node("States").get_node("Walk")

func execute(delta : float) -> void:
	if goap.world.get_node("House"):
		target = goap.world.get_node("House")
		walk_state.target = target.position
		
		if (target.position - goap.fsm.get_node("Actor").position).length() > walk_state.speed:
			goap.fsm.pop_state()
			goap.fsm.push_state(walk_state)
		else:
			effects["sleep"] = true
			goap.fsm.pop_state()
			goap.pop_action()
	else:
		emit_signal("canceled")

func _setpt_up_preconditions() -> void:
	#preconditions["has_iron"] = false
	pass

func _setpt_up_effects() -> void:
	effects["sleep"] = true
