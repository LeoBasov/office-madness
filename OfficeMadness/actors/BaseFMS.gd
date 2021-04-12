extends Node

enum State {IDLE, WALK}
var return_state = State.IDLE
var states : Dictionary = {}
var current_state

func execute(delta):
	var new_state = states[current_state].execute(delta)
	
	if new_state != current_state:
		current_state = new_state
		states[current_state].initialize()
