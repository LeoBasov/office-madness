extends Node

var actor : AnimatedSprite
var state_list =  load("res://actors/StateList.gd").new()
var return_state = null

func initialize():
	actor.animation = "idle_down"
	actor.play()
	return_state = state_list.State.IDLE
	
func execute(delta):
	return return_state

func _on_actor_navigate(position):
	return_state = state_list.State.WALK
