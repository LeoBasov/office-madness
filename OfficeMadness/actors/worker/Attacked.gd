extends Node

var actor : AnimatedSprite
var state_list =  load("res://actors/worker/StateList.gd").new()
var return_state = null
var speed : float = 100

func initialize():
	actor.get_node("Reaction").play()
	actor.get_node("Reaction").show()
	
	actor.animation = "idle_down"
	actor.play()
	
	return_state = state_list.State.ATTACKED
	
func execute(delta):
	return return_state

func _on_Reaction_animation_finished():
	actor.get_node("Reaction").stop()
	actor.get_node("Reaction").hide()
	
	return_state = state_list.State.IDLE
