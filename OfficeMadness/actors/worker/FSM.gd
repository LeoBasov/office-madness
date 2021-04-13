extends "res://actors/FMS.gd"

var state_list =  load("res://actors/worker/StateList.gd").new()

func _ready():
	states[state_list.State.IDLE] = $Idle
	states[state_list.State.WALK] = $Walk
	states[state_list.State.WORK] = $Work
	
	current_state = state_list.State.IDLE
	
func set_actor(new_actor):
	.set_actor(new_actor)
	
	for state in states.values():
		new_actor.connect("navigate", state, "_on_actor_navigate")
