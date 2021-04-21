extends Node

var fsm : Node2D
var model : Node2D

func initialize(new_fsm :  Node2D) -> void:
	fsm = new_fsm
	model = fsm.get_node("Model")

func execute() -> void:
	pass
