extends Node

var actor : AnimatedSprite
var speed : float = 100
var state_list =  load("res://actors/worker/StateList.gd").new()
var return_state = null
var work : bool = false

func initialize():
	return_state = state_list.State.WALK
	
func execute(delta):
	var direction = actor._move(delta, speed)
	
	if !direction.length() and work:
		return_state = state_list.State.WORK
		work = false
	elif !direction.length():
		return_state = state_list.State.IDLE
	
	return return_state

func _on_actor_navigate(position):
	actor._navigate(position)
