extends "res://goap/Action.gd"

var walk_state
var target = null

func reset() -> void:
	target = null
	walk_state = goap.fsm.get_node("States").get_node("Walk")

func execute(delta : float) -> void:
	if target == null and get_tree().get_nodes_in_group("fields"):
		target = get_tree().get_nodes_in_group("fields")[0]
		walk_state.target = target.position
	elif target:
		if !walk_state.is_in_range:
			goap.fsm.pop_state()
			goap.fsm.push_state(walk_state)
		else:
			goap.condition_state["has_iron"] = true
			goap.fsm.pop_state()
			goap.pop_action()
			goap.fsm.get_node("Actor").get_node("Ore").show()
	else:
		target = null
		emit_signal("canceled")

func _setpt_up_preconditions() -> void:
	preconditions["has_iron"] = false
	preconditions["has_fields"] = true

func _setpt_up_effects() -> void:
	effects["has_iron"] = true
