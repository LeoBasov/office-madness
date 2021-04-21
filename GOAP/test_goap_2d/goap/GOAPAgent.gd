extends "res://goap/GOAP.gd"

func _ready() -> void:
	set_fsm($Dwarf)
	
	goal_key = "has_iron"
	goal_value = true

func _set_up() -> void:
	condition_state["has_axe"] = false
	condition_state["has_iron"] = false

func _action_canceled():
	_plan(goal_key, goal_value)
