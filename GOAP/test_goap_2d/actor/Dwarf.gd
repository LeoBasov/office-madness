extends "res://actor_2d/Actor2d.gd"

var axe : bool = false

func _ready() -> void:
	._ready()
	push_state($States/Walk)
