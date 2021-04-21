extends Node

var goap : Node
var preconditions : Dictionary
var effects : Dictionary
var cost : float = 1.0
var fsm_states : Array setget , get_fsm_states # states to be pushed to the FSM in execution order

func initialize(new_goap : Node) -> void:
	goap = new_goap
	
	_setpt_up_preconditions()
	_setpt_up_effects()
	_set_up_fsm_states()
	
func get_fsm_states() -> Array:
	return fsm_states
	
func reset() -> void:
	# TD IMPLEMENT
	pass
	
func check_goal(key, value) -> bool:
	if effects.has(key) and effects[key] == value:
		return true
	else:
		return false
	
func check_condition(condition_state : Dictionary) -> bool:
	# TD IMPLEMENT
	return false
	
func check_world_condition() -> bool:
	# TD IMPLEMENT
	return false

func _setpt_up_preconditions() -> void:
	# TD IMPLEMENT
	pass

func _setpt_up_effects() -> void:
	# TD IMPLEMENT
	pass
	
func _set_up_fsm_states() -> void:
	# TD IMPLEMENT
	pass

func _add_precondition(key, value) -> void:
	preconditions[key] = value

func _add_effect(key, value) -> void:
	effects[key] = value

func _remove_precondition(key) -> void:
	if preconditions.has(key):
		preconditions.erase(key)

func _remove_effect(key) -> void:
	if effects.has(key):
		effects.erase(key)
