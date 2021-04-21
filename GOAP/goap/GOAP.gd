extends Node

var fsm : Node
var world_state : Node

class Leaf:
	var condition_sate : Dictionary = {}
	var children : Array = []
	var action
	
	func _init(condition_state : Dictionary) -> void:
		self.condition_state = condition_state.duplicate(true)
		
	func add_action(action) -> void:
		for key in action.effects.keys():
			self.condition_state[key] = action.effects[key]
	
		self.action = action

func _ready() -> void:
	for action in $Actions.get_children():
		action.initialize(self)

func initialize(new_world_state : Node) -> void:
	world_state = new_world_state
	_set_up()

func _set_up() -> void:
	# TO IMPLEMENT
	# set up condition state
	# set_ up FSM
	pass

func build_tree() -> void:
	var availible_actions : Array = []
	var leaf = Leaf.new(_set_up_condition_state())
	
	for action in $Actions.get_children():
		action.reset()
		
		if action.check_world_condition():
			availible_actions.push_back(action)
		
	# TODO

func _set_up_condition_state() -> Dictionary:
	# TO IMPLEMENT
	return {}

func _build_leaf(parent : Leaf, availible_actions : Array) -> void:
	for action in availible_actions:
		if action.check_condition(parent.condition_state):
			var leaf = Leaf.new(parent.condition_state)
			
			leaf.add_action(action)
			parent.children.push_back(leaf)
			
			_build_leaf(leaf, availible_actions)
