extends Node

var state_stack : Array

func _ready() -> void:
	_fsm_ready()
		
func _fsm_ready() -> void:
	state_stack = []
	
	for state in $States.get_children():
		state.initialize(self)
		
func _process(delta: float) -> void:
	var current_state = get_current_state()
	
	if current_state != null:
		current_state.execute(delta)
	
func pop_state():
	return state_stack.pop_back()
	
func push_state(state):
	if get_current_state() != state:
		state_stack.push_back(state)
	
func get_current_state():
	return state_stack[-1] if state_stack.size() > 0 else null
