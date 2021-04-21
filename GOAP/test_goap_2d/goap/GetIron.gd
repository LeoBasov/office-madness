extends "res://goap/Action.gd"

func check_world_condition() -> bool:
	return true

func _setpt_up_preconditions() -> void:
	preconditions["has_axe"] = true

func _setpt_up_effects() -> void:
	effects["has_iron"] = true
	
func _set_up_fsm_states() -> void:
	fsm_state = goap.fsm.get_node("States").get_node("Mine")
