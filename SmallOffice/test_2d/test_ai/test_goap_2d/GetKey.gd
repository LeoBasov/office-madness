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
	for key in get_tree().get_nodes_in_group("key"):
		if key.reachable:
			target = key
			return
	
	emit_signal("canceled", null, false)

func _execute_action() -> void:
	goap.condition_state["has_key"] = true

func _on_area_entered(area : Area2D) -> void:
	var object = area.get_owner()
	
	if object.is_in_group("object") and object.is_in_group("door") and !object.open:
		emit_signal("canceled", object, true)
