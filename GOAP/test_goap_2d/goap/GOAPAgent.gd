extends "res://goap/GOAP.gd"

func _ready() -> void:
	set_fsm($Dwarf)
	
	goal_key = "stored_iron"
	goal_value = true
	
func _process(delta: float) -> void:
	if get_tree().get_nodes_in_group("fields"):
		condition_state["has_fields"] = true
	else:
		condition_state["has_fields"] = false

func _set_up() -> void:
	condition_state["has_axe"] = false
	condition_state["has_iron"] = false
	condition_state["stored_iron"] = false
	condition_state["has_fields"] = false
	condition_state["sleep"] = false
	
	$SleepTimer.start()

func _action_canceled():
	_plan(goal_key, goal_value)

func _on_SleepTimer_timeout() -> void:
	goal_key = "sleep"
	goal_value = true


func _on_Sleep_awake() -> void:
	goal_key = "stored_iron"
	goal_value = true
	
	_plan(goal_key, goal_value)
	$SleepTimer.start()
