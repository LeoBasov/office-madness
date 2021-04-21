extends Node

var condition_state : Dictionary
var fsm : Node
var world_state : Node

func _ready() -> void:
	for action in $Actions.get_children():
		action.initialize(self)

func initialize(new_world_state : Node) -> void:
	world_state = new_world_state
	_set_up_condition_state()

func _set_up_condition_state() -> void:
	pass
