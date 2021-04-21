extends "res://actor_2d/Actor2d.gd"

var axe_life : int = 3

func _ready() -> void:
	._ready()
	push_state($States/Walk)
	
	$Actor/Axe.hide()

func set_world(world):
	for state in $States.get_children():
		state.world = world
