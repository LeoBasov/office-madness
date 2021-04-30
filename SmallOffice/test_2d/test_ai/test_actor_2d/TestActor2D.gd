extends "res://ai/actor_2d/Actor2D.gd"

func initialize(world) -> void:
	$TestFSM2D.set_actor(self)
	$TestGOAP2D.initialize(world)
	$TestGOAP2D.set_fsm($TestFSM2D)

	$Area2D.connect("area_entered", $TestGOAP2D/Actions/GetKey, "_on_area_entered")
