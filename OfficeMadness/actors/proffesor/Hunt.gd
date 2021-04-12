extends Node

var actor : AnimatedSprite
var state_list =  load("res://actors/proffesor/StateList.gd").new()
var return_state = null

func initialize():
	actor.animation = "idle_down"
	actor.play()
	return_state = state_list.State.HUNT
	
func execute(delta):
	return return_state
