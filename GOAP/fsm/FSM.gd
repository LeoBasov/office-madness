extends Node

var state_stack : Array

func _ready() -> void:
	state_stack = []
	
	for state in $States.get_children():
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
