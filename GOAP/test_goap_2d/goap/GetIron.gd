extends "res://goap/Action.gd"

var target = null
var axe_break_state

func _ready() -> void:
	cost = 2

func reset() -> void:
	target = null
	axe_break_state = goap.fsm.get_node("States").get_node("AxeBreak")

func execute(delta : float) -> void:
	if target:
		if !goap.fsm.is_in_range:
			goap.fsm.move()
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
		goap.fsm.target = target.position

func _setpt_up_preconditions() -> void:
	preconditions["has_iron"] = false
	preconditions["has_axe"] = true

func _setpt_up_effects() -> void:
	effects["has_iron"] = true
