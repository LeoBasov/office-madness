extends "res://ai/goap/GOAP.gd"

func _ready():
	goals["has_key"] = true
	goals["door_open"] = true
	
	current_goal = "has_key"

func _goal_unreachable():
	# TO IMPLEMENT
	pass

func _set_up() -> void:
	# world condition state
	condition_state["key_availible"] = false
	
	condition_state["door_open"] = true
	
	# slef condition state
	condition_state["has_key"] = false
	
func _update_world_state() -> void:
	if get_tree().get_nodes_in_group("key").size():
		condition_state["key_availible"] = true
	elif !get_tree().get_nodes_in_group("key").size():
		condition_state["key_availible"] = false

func _action_canceled(object, is_attached):
	print(object.name)
	
	if is_attached and object.is_in_group("door"):
		var current_action = get_current_action()
		
		if !object.open and !condition_state["has_key"]:
			current_action.target.reachable = false
			condition_state["door_open"] = false
			goals["door_open"] = true
			current_goal = "door_open"
			$Actions/OpenDoor.door = object
			_plan()
