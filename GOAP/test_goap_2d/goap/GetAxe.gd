extends "res://goap/Action.gd"

var target = null
var get_axe_state

func reset() -> void:
	target = null
	get_axe_state = goap.fsm.get_node("States").get_node("GetAxe")

func execute(delta : float) -> void:
	if target:
		if !goap.fsm.is_in_range:
			goap.fsm.move()
		else:
			goap.world.get_node("Stack").axe_amount -= 1
			goap.condition_state["has_axe"] = true
			goap.fsm.pop_state()
			goap.fsm.push_state(get_axe_state)
			goap.pop_action()
	else:
		target = get_tree().get_nodes_in_group("axe_stacks")[0]
		goap.fsm.target = target.position

func _setpt_up_preconditions() -> void:
	preconditions["has_axe"] = false
	preconditions["axe_availible"] = true

func _setpt_up_effects() -> void:
	effects["has_axe"] = true
