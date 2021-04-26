extends "res://fsm/FSM.gd"

var is_in_range : bool setget , _is_in_range 
var target setget _set_target

func move():
	pop_state()
	push_state($States/Move)

func _is_in_range() -> bool:
	return $States/Move.is_in_range

func _set_target(new_target):
	$States/Move.target = new_target
