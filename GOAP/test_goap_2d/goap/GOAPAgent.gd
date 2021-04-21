extends "res://goap/GOAP.gd"

func _ready() -> void:
	set_fsm($Dwarf)

func _set_up() -> void:
	condition_state["has_axe"] = false
	condition_state["has_iron"] = false
	
	_plan("has_iron", true)

func _action_canceled():
	_plan("has_iron", true)
