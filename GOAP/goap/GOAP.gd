extends Node

var condition_state : Dictionary
var fsm : Node
var world_state : Node

func _ready() -> void:
	for action in $Actions.get_children():
		action.initialize(self)

func initialize(new_world_state : Node) -> void:
	world_state = new_world_state
	_set_up()

func _set_up() -> void:
	#set up condition state
	#set_ up FSM
	pass
