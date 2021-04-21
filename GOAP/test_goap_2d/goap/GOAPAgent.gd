extends "res://goap/GOAP.gd"

var state_get_iron
var state_get_axe

func _ready() -> void:
	set_fsm($Dwarf)

func _set_up() -> void:
	condition_state["has_axe"] = false
	condition_state["has_iron"] = false
	
	_plan("has_iron", true)

func _action_canceled():
	_plan("has_iron", true)
