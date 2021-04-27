extends "res://ai/fsm/State.gd"

var actor : Node2D

func initialize(new_fsm :  Node) -> void:
	.initialize(new_fsm)
	actor = new_fsm.actor
