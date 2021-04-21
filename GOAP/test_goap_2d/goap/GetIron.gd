extends "res://goap/Action.gd"

var target = null
var walk_state
var axe_break_state

func reset() -> void:
	target = null
	walk_state = goap.fsm.get_node("States").get_node("Walk")
	axe_break_state = goap.fsm.get_node("States").get_node("AxeBreak")

func execute(delta : float) -> void:
	if target:
		if (target.position - goap.fsm.get_node("Actor").position).length() > walk_state.speed:
			goap.fsm.pop_state()
			goap.fsm.push_state(walk_state)
		else:
			goap.condition_state["has_iron"] = true
			goap.fsm.pop_state()
			goap.pop_action()
			
			goap.fsm.axe_life -= 1
			goap.fsm.get_node("Actor").get_node("Ore").show()
			
			if !goap.fsm.axe_life:
				goap.condition_state["has_axe"] = false
				goap.fsm.push_state(axe_break_state)
				
	else:
		target = get_tree().get_nodes_in_group("mines")[0]
		walk_state.target = target.position

func _setpt_up_preconditions() -> void:
	preconditions["has_axe"] = true

func _setpt_up_effects() -> void:
	effects["has_iron"] = true
