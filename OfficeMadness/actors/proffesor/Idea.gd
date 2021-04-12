extends Node

var actor : AnimatedSprite
var state_list =  load("res://actors/proffesor/StateList.gd").new()
var return_state = null

func initialize():
	actor.animation = "idle_down"
	actor.play()
	actor.get_node("IdeaBulb").show()
	return_state = state_list.State.IDEA
	$IdeaTimer.start()
	
func execute(delta):
	return return_state


func _on_IdeaTimer_timeout():
	actor.get_node("IdeaBulb").hide()
	return_state = state_list.State.LOOP
