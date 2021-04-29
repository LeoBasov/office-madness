extends "res://ai/goap/GOAP.gd"

func _ready():
	goals["has_key"] = true
	
	current_goal = "has_key"

func _goal_unreachable():
	# TO IMPLEMENT
	pass

func _set_up() -> void:
	# world condition state
	condition_state["key_availible"] = false
	
	condition_state["door_1_open"] = true
	
	# slef condition state
	condition_state["has_key"] = false
	
func _update_world_state() -> void:
	if get_tree().get_nodes_in_group("key").size():
		condition_state["key_availible"] = true
	elif !get_tree().get_nodes_in_group("key").size():
		condition_state["key_availible"] = false
