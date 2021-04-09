extends "res://actors/BaseFMS.gd"

var actor : AnimatedSprite
var states : Dictionary = {}
var current_state

func _ready():
	states[State.IDLE] = $Idle
	states[State.WALK] = $Walk
	
	current_state = State.IDLE
	
func set_actor(new_actor):
	actor = new_actor
	
	for state in states.values():
		state.actor = actor
		actor.connect("navigate", state, "_on_actor_navigate")
		actor.connect("animation_finished", state, "_on_animation_finished")
	
	states[current_state].initialize()

func execute(delta):
	var new_state = states[current_state].execute(delta)
	
	if new_state != current_state:
		current_state = new_state
		states[current_state].initialize()
