extends Node

signal goal_unreachable

var fsm : Node
var world : Node
var condition_state : Dictionary
var action_stack : Array
var goals : Dictionary
var current_goal

class Leaf:
	var condition_state : Dictionary = {}
	var children : Array = []
	var action
	var goal_reached = false
	
	func _init(new_condition_state : Dictionary) -> void:
		self.condition_state = new_condition_state.duplicate(true)
		
	func add_action(new_action) -> void:
		for key in new_action.effects.keys():
			self.condition_state[key] = new_action.effects[key]
	
		self.action = new_action
		
class ActionPath:
	var valid : bool = false
	var total_cost : float = 0.0
	var actions : Array = []
	
	func copy(path) -> void:
		self.total_cost = path.total_cost
		self.actions = path.actions.duplicate()

# OVERRIDE THESE
#===============================================================================
func _goal_unreachable():
	# TO IMPLEMENT
	pass

func _set_up() -> void:
	# TO IMPLEMENT
	# set_ up FSM
	# _set_up_condition_state
	pass
	
func _update_world_state() -> void:
	# here checks of the world and its state happen
	pass
#===============================================================================
func _action_canceled():
	_plan()

func _process(delta: float) -> void:
	var current_action = get_current_action()
	_update_world_state()
	
	if current_action != null and current_action.check_condition(condition_state):
		current_action.execute(delta)
	else:
		_plan()
	
func pop_action():
	return action_stack.pop_back()
	
func push_action(action):
	if get_current_action() != action:
		action_stack.push_back(action)
	
func get_current_action():
	return action_stack[-1] if action_stack.size() > 0 else null

func initialize(new_world : Node) -> void:
	world = new_world
	_set_up()
	
func set_fsm(new_fsm):
	fsm = new_fsm
	
	for action in $Actions.get_children():
		action.initialize(self)
		action.connect("canceled", self, "_action_canceled")
	
func _plan() -> void:
	var root = _build_tree()
	var path = _get_path(root)
	
	_set_up_action_stack(path)

func _build_tree() -> Leaf:
	var root = Leaf.new(condition_state)
	var actions = $Actions.get_children()
	
	for action in actions:
		action.reset()
		
	_build_leaf(root, actions)
	
	return root

func _build_leaf(parent : Leaf, availible_actions : Array) -> void:
	for action in availible_actions:
		if action.check_condition(parent.condition_state):
			var leaf = Leaf.new(parent.condition_state)
			
			leaf.add_action(action)
			parent.children.push_back(leaf)
			
			if action.check_goal(current_goal, goals[current_goal]):
				leaf.goal_reached = true
			else:
				var new_actions = []
				
				for new_action in availible_actions:
					if new_action != action:
						new_actions.push_back(new_action)
				
				_build_leaf(leaf, new_actions)

func _get_paths(leaf : Leaf, path : ActionPath, paths : Array) -> void:
	var new_path = ActionPath.new()
	new_path.copy(path)
	
	for i in range(leaf.children.size()):
		if i == 0:
			path.total_cost += leaf.children[i].action.cost
			path.valid = leaf.children[i].goal_reached
			path.actions.push_back(leaf.children[i].action)
			
			_get_paths(leaf.children[i], path, paths)
		else:
			var loc_path = ActionPath.new()
			loc_path.copy(new_path)
			
			paths.push_back(loc_path)
			
			loc_path.total_cost += leaf.children[i].action.cost
			loc_path.valid = leaf.children[i].goal_reached
			loc_path.actions.push_back(leaf.children[i].action)
			
			_get_paths(leaf.children[i], loc_path, paths)

func _get_path(root : Leaf):
	var paths = []
	var path = ActionPath.new()
	var cost = null
	var selected_path_id : int = -1
	
	paths.push_back(path)
	_get_paths(root, path, paths)
	
	for i in range(paths.size()):
		if paths[i].valid:
			if cost == null or paths[i].total_cost < cost:
				selected_path_id = i
				cost = paths[i].total_cost
				
	if selected_path_id < 0:
		emit_signal("goal_unreachable")
			
	return paths[selected_path_id]

func _set_up_action_stack(path : ActionPath) -> void:
	var actions = path.actions
	
	action_stack.clear()
	actions.invert()

	for action in actions:
		push_action(action)
