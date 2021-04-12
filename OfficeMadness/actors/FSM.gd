extends "res://actors/BaseFMS.gd"

var actor : AnimatedSprite
var state_list =  load("res://actors/StateList.gd").new()

func _ready():
	states[state_list.State.IDLE] = $Idle
	states[state_list.State.WALK] = $Walk
	
	current_state = state_list.State.IDLE
	
func set_actor(new_actor):
	actor = new_actor
	
	for state in states.values():
		state.actor = actor
		actor.connect("navigate", state, "_on_actor_navigate")
		actor.connect("animation_finished", state, "_on_animation_finished")
	
	states[current_state].initialize()
