extends "res://actor_2d/State2d.gd"

var target : Vector2 setget set_target
var speed : float = 200.0
var is_in_range : bool = false

func set_target(new_target : Vector2) -> void:
	target = new_target
	is_in_range = false

func execute(delta : float) -> void:
	is_in_range = _is_in_range(delta)
	
	if !is_in_range:
		actor.position += (target - actor.position).normalized() * speed * delta

func _is_in_range(delta : float) -> bool:
	return (target - actor.position).length() < speed * delta
