extends Node2D

var state_stack : Array

func _ready() -> void:
	state_stack = []
	
	for state in get_tree().get_nodes_in_group("states"):
		if is_a_parent_of (state):
			state.initialize(self)
	
func update() -> void:
	var current_state = get_current_state()
	
	if current_state != null:
		current_state.execute()
	
func pop_state():
	return state_stack.pop_front()
	
func push_state(state):
	if get_current_state() != state:
		state_stack.push_back(state)
	
func get_current_state():
	return state_stack[-1] if state_stack.size() > 0 else null
