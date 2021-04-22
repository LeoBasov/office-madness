extends "res://goap/GOAP.gd"

func _ready() -> void:
	set_fsm($Dwarf)
	
	goals["stored_iron"] = true
	goals["sleep"] = true
	
	current_goal = "stored_iron"
	
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

func _on_SleepTimer_timeout() -> void:
	current_goal = "sleep"

func _on_Sleep_awake() -> void:
	current_goal = "stored_iron"
	
	_plan()
	$SleepTimer.start()
