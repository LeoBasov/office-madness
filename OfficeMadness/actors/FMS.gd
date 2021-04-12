extends Node

var states : Dictionary = {}
var current_state

func execute(delta):
	var new_state = states[current_state].execute(delta)
	
	if new_state != current_state:
		current_state = new_state
		states[current_state].initialize()

func set_actor(new_actor):
	for state in states.values():
		state.actor = new_actor
	
	states[current_state].initialize()
