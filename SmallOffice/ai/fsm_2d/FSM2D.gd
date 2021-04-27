extends "res://ai/fsm/FSM.gd"

var actor : Node2D
var is_in_range : bool setget , _is_in_range 
var target : Vector2 setget _set_target

func set_actor(new_actor : Node2D) -> void:
	actor = new_actor
	_initialize()

func move():
	pop_state()
	push_state($States/Move)

func _is_in_range() -> bool:
	return $States/Move.is_in_range

func _set_target(new_target : Vector2) -> void:
	$States/Move.target = new_target
