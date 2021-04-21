extends "res://actor_2d/State2d.gd"

func execute(delta : float) -> void:
	actor.position += Vector2(1.0, 1.0)
