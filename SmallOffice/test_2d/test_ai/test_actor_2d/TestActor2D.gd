extends "res://ai/actor_2d/Actor2D.gd"

func initialize(world) -> void:
	$TestFSM2D.set_actor(self)
	$TestGOAP2D.initialize(world)
	$TestGOAP2D.set_fsm($FSM2D)
