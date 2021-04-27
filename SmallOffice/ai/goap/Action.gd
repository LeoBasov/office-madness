extends Node

signal canceled

var goap : Node
var preconditions : Dictionary
var effects : Dictionary
var cost : float = 1.0 setget , get_cost

# OVERRIDE THESE
#===============================================================================
func execute(delta : float) -> void:
	# TD IMPLEMENT
	pass

func reset() -> void:
	# TD IMPLEMENT
	pass

func _setpt_up_preconditions() -> void:
	# TD IMPLEMENT
	pass

func _setpt_up_effects() -> void:
	# TD IMPLEMENT
	pass
#===============================================================================

# OVERRIDE THESE FOR DETAILED COST CALCULATION
#-------------------------------------------------------------------------------
func get_cost() -> float:
	return cost
#-------------------------------------------------------------------------------

func initialize(new_goap : Node) -> void:
	goap = new_goap
	
	_setpt_up_preconditions()
	_setpt_up_effects()
	
func check_goal(key, value) -> bool:
	return effects.has(key) and (effects[key] == value)
	
func check_condition(condition_state : Dictionary) -> bool:
	var ret_val = true
	
	for key in preconditions.keys():
		ret_val = ret_val and (condition_state[key] == preconditions[key])
		
	return ret_val

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
