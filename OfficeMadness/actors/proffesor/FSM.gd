extends "res://actors/FMS.gd"

var state_list =  load("res://actors/proffesor/StateList.gd").new()

func _ready():
	states[state_list.State.IDLE] = $Idle
	
	current_state = state_list.State.IDLE
