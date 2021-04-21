extends "res://actor_2d/Actor2d.gd"

func _ready() -> void:
	._ready()
	push_state($States/Walk)
