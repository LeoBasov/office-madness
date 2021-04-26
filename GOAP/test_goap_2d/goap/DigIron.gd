extends "res://goap/Action.gd"

var target = null
var walk_state

func reset() -> void:
	target = null
	walk_state = goap.fsm.get_node("States").get_node("Walk")

func execute(delta : float) -> void:
	if get_tree().get_nodes_in_group("fields"):
		target = get_tree().get_nodes_in_group("fields")[0]
		walk_state.target = target.position
		
		if (target.position - goap.fsm.get_node("Actor").position).length() > walk_state.speed * delta:
			goap.fsm.pop_state()
			goap.fsm.push_state(walk_state)
		else:
			goap.condition_state["has_iron"] = true
			goap.fsm.pop_state()
			goap.pop_action()
			goap.fsm.get_node("Actor").get_node("Ore").show()
	else:
		emit_signal("canceled")

func _setpt_up_preconditions() -> void:
	preconditions["has_iron"] = false
	preconditions["has_fields"] = true

func _setpt_up_effects() -> void:
	effects["has_iron"] = true
