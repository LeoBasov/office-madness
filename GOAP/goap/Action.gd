extends Node

var goap : Node
var preconditions : Dictionary
var effects : Dictionary
var cost : float = 1.0

func initialize(new_goap : Node) -> void:
	_setpt_up_preconditions()
	_setpt_up_effects()
	
	goap = new_goap

func _setpt_up_preconditions() -> void:
	pass

func _setpt_up_effects() -> void:
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
