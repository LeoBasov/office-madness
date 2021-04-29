extends Node

signal canceled(object, is_attached)

var fsm : Node

func initialize(new_fsm :  Node) -> void:
	fsm = new_fsm

# OVERRIDE THESE
#===============================================================================
func execute(delta : float) -> void:
	pass
#===============================================================================
