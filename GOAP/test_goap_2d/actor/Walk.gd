extends "res://actor_2d/State2d.gd"

var target : Vector2
var speed : float = 200.0

func execute(delta : float) -> void:
	actor.position += (target - actor.position).normalized() * speed * delta
