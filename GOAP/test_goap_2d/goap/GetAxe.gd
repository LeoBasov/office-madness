extends "res://goap/Action.gd"

var target = null
var walk_state
var get_axe_state

func reset() -> void:
	target = null
	walk_state = goap.fsm.get_node("States").get_node("Walk")
	get_axe_state = goap.fsm.get_node("States").get_node("GetAxe")

func execute(delta : float) -> void:
	if target:
		if (target.position - goap.fsm.get_node("Actor").position).length() > walk_state.speed * delta:
			goap.fsm.pop_state()
			goap.fsm.push_state(walk_state)
		else:
			goap.world.get_node("Stack").axe_amount -= 1
			goap.condition_state["has_axe"] = true
			goap.fsm.pop_state()
			goap.fsm.push_state(get_axe_state)
			goap.pop_action()
	else:
		target = get_tree().get_nodes_in_group("axe_stacks")[0]
		walk_state.target = target.position

func _setpt_up_preconditions() -> void:
	preconditions["has_axe"] = false
	preconditions["axe_availible"] = true

func _setpt_up_effects() -> void:
	effects["has_axe"] = true
