extends "res://actor_2d/State2d.gd"

func execute(delta : float) -> void:
	print("Mine")
	fsm.pop_state()
