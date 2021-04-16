extends Node

var actor : AnimatedSprite
var state_list =  load("res://actors/worker/StateList.gd").new()
var return_state = null
var speed : float = 100

func initialize():
	return_state = state_list.State.IDLE
	
func execute(delta):
	var direction = actor._move(delta, speed)
	
	return return_state
