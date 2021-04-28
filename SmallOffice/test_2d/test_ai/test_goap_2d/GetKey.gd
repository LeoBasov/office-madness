extends "res://ai/goap_2d/Action2D.gd"

func _ready() -> void:
	cost = 1.0

func reset() -> void:
	target = null

func _setpt_up_preconditions() -> void:
	preconditions["key_availible"] = true
	preconditions["has_key"] = false

func _setpt_up_effects() -> void:
	effects["has_key"] = true

func _target_exists() -> bool:
	if get_tree().get_nodes_in_group("key").size():
		return true
	else:
		return false

func _get_target() -> void:
	target = get_tree().get_nodes_in_group("key")[0]

func _execute_action() -> void:
	goap.condition_state["has_key"] = true
