extends "res://actor_2d/Move.gd"

func _is_in_range(delta : float) -> bool:
	return (target - actor.position).length() < speed * delta
	
func _move(delta : float) -> void:
	actor.position += (target - actor.position).normalized() * speed * delta
