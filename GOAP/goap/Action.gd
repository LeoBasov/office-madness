extends Node

var goap : Node
var preconditions : Dictionary
var effects : Dictionary
var cost : float = 1.0

func initialize(new_goap : Node) -> void:
	setpt_up_preconditions()
	setpt_up_effects()
	
	goap = new_goap

func setpt_up_preconditions() -> void:
	pass

func setpt_up_effects() -> void:
	pass

func add_precondition(key, value) -> void:
	preconditions[key] = value

func add_effect(key, value) -> void:
	effects[key] = value

func remove_precondition(key) -> void:
	if preconditions.has(key):
		preconditions.erase(key)

func remove_effect(key) -> void:
	if effects.has(key):
		effects.erase(key)
