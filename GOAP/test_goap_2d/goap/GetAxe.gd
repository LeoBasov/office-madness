extends "res://goap/Action.gd"

func check_world_condition() -> bool:
	return true

func _setpt_up_preconditions() -> void:
	preconditions["has_axe"] = false

func _setpt_up_effects() -> void:
	effects["has_axe"] = true
	
func _set_up_fsm_states() -> void:
	fsm_states = [goap.fsm.get_node("States").get_node("PickUpAxe")]
