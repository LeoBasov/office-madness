extends "res://actors/FMS.gd"

var state_list =  load("res://actors/proffesor/StateList.gd").new()

func _ready():
	states[state_list.State.IDLE] = $Idle
	states[state_list.State.LOOP] = $Loop
	states[state_list.State.IDEA] = $Idea
	
	current_state = state_list.State.LOOP
