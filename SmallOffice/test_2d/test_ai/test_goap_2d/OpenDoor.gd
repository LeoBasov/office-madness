extends "res://ai/goap_2d/Action2D.gd"

var door = null

func _target_exists() -> bool:
	if door == null:
		return false
	else:
		return true

func _get_target() -> void:
	target = door

func _execute_action() -> void:
	door.open = true
	door = null

func reset() -> void:
	.reset()

func _setpt_up_preconditions() -> void:
	preconditions["door_open"] = false
	preconditions["has_key"] = true

func _setpt_up_effects() -> void:
	effects["door_open"] = true
