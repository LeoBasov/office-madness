extends Node

var actor : AnimatedSprite
var speed : float = 100
var state_list =  load("res://actors/StateList.gd").new()
var return_state = null

func initialize():
	return_state = state_list.State.WALK
	# load and play animation
	
func execute(delta):
	var direction = actor._move(delta, speed)
	
	if !direction.length():
		return_state = state_list.State.IDLE
	
	return return_state

func _on_actor_navigate(position):
	actor._navigate(position)
