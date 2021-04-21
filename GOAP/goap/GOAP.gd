extends Node

var fsm : Node
var world_state : Node
var condition_state : Dictionary

class Leaf:
	var condition_state : Dictionary = {}
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
	var actions : Array = []
	
	func copy(path) -> void:
		self.valid = path.valid
		self.total_cost = path.total_cost
		self.actions = path.actions

# OVERRIDE THESE
#===============================================================================
func _action_canceled():
	# TO IMPLEMENT
	pass

func _set_up() -> void:
	# TO IMPLEMENT
	# set_ up FSM
	# _set_up_condition_state
	pass
#===============================================================================

func initialize(new_world_state : Node) -> void:
	world_state = new_world_state
	_set_up()
	
func set_fsm(new_fsm):
	fsm = new_fsm
	
	for action in $Actions.get_children():
		action.initialize(self)
	
	for state in fsm.get_node("States").get_children():
		state.connect("canceled", self, "_action_canceled")
	
func _plan(goal_key, goal_value) -> void:
	var root = _build_tree(goal_key, goal_value)
	var path = _get_path(root)
	
	_set_up_fsm(path)

func _build_tree(goal_key, goal_value) -> Leaf:
	var root = Leaf.new(condition_state)
	var actions = $Actions.get_children()
	
	for action in actions:
		action.reset()
		
	_build_leaf(root, actions, goal_key, goal_value)
	
	return root

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
			path.actions.push_back(leaf.children[i].action)
			
			_get_paths(leaf.children[i], path, paths)
		else:
			var new_path = ActionPath.new()
			new_path.copy(path)
			
			paths.push_back(new_path)
			
			new_path.total_cost += leaf.children[i].action.cost
			new_path.valid = leaf.goal_reached
			new_path.actions.push_back(leaf.children[i].action)
			
			_get_paths(leaf.children[i], new_path, paths)

func _get_path(root : Leaf):
	var paths = []
	var path = ActionPath.new()
	var cost : float = 0.0
	var selected_path_id : int = 0
	
	paths.push_back(path)
	_get_paths(root, path, paths)
	
	cost = path.total_cost
	
	for i in range(paths.size()):
		if paths[i].total_cost < cost:
			selected_path_id = i
			cost = paths[i].total_cost
			
	return paths[selected_path_id]

func _set_up_fsm(path : ActionPath) -> void:
	var actions = path.actions
	
	fsm.state_stack.clear()
	actions.invert()

	for action in actions:
		fsm.push_state(action.get_fsm_state())
