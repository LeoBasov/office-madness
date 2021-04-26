extends "res://goap/GOAP.gd"

func _ready() -> void:
	set_fsm($Dwarf)
	
	goals["stored_iron"] = true
	goals["sleep"] = true
	
	current_goal = "stored_iron"
	
func _update_world_state() -> void:
	if get_tree().get_nodes_in_group("fields"):
		condition_state["has_fields"] = true
	else:
		condition_state["has_fields"] = false
		
	if world.get_node("Warehouse").ore_amount:
		condition_state["ore_availible"] = true
	else:
		condition_state["ore_availible"] = false
		
	if world.get_node("Stack").axe_amount:
		condition_state["axe_availible"] = true
	else:
		condition_state["axe_availible"] = false

func _set_up() -> void:
	condition_state["axe_availible"] = false
	condition_state["ore_availible"] = false
	
	condition_state["has_axe"] = false
	condition_state["has_iron"] = false
	condition_state["stored_iron"] = false
	condition_state["has_fields"] = false
	condition_state["sleep"] = false
	
	$SleepTimer.start()

func _on_SleepTimer_timeout() -> void:
	current_goal = "sleep"

func _on_Sleep_awake() -> void:
	current_goal = "stored_iron"
	
	_plan()
	$SleepTimer.start()

func _goal_unreachable():
	for key in goals.keys():
		current_goal = key
		_plan()
