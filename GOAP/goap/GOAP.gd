extends Node

var fsm : Node
var world_state : Node
var condition_state : Dictionary

class Leaf:
	var condition_sate : Dictionary = {}
	var children : Array = []
	var action
	var goal_reached = false
	
	func _init(condition_state : Dictionary) -> void:
		self.condition_state = condition_state.duplicate(true)
		
	func add_action(action) -> void:
		for key in action.effects.keys():
			self.condition_state[key] = action.effects[key]
	
		self.action = action
		
class ActionPath:
	var valid : bool = false
	var total_cost : float = 0.0

func _ready() -> void:
	for action in $Actions.get_children():
		action.initialize(self)

func initialize(new_world_state : Node) -> void:
	world_state = new_world_state
	_set_up()

func _set_up() -> void:
	# TO IMPLEMENT
	# set_ up FSM
	# _set_up_condition_state
	pass

func _build_tree(goal_key, goal_value) -> void:
	var availible_actions : Array = []
	var root = Leaf.new(condition_state)
	
	for action in $Actions.get_children():
		action.reset()
		
		if action.check_world_condition():
			availible_actions.push_back(action)
		
	_build_leaf(root, availible_actions, goal_key, goal_value)

func _build_leaf(parent : Leaf, availible_actions : Array, goal_key, goal_value) -> void:
	for action in availible_actions:
		if action.check_condition(parent.condition_state):
			var leaf = Leaf.new(parent.condition_state)
			
			leaf.add_action(action)
			parent.children.push_back(leaf)
			
			if action.check_goal(goal_key, goal_value):
				leaf.goal_reached = true
			else:
				_build_leaf(leaf, availible_actions, goal_key, goal_value)

func _get_paths(leaf : Leaf, path : ActionPath, paths : Array) -> void:
	for i in range(leaf.children.size()):
		if i == 0:
			path.total_cost += leaf.children[i].action.cost
			path.valid = leaf.goal_reached
			
			_get_paths(leaf.children[i], path, paths)
		else:
			var new_path = ActionPath.new()
			
			paths.push_back(new_path)
			
			new_path.total_cost += leaf.children[i].action.cost
			new_path.valid = leaf.goal_reached
			
			_get_paths(leaf.children[i], new_path, paths)
