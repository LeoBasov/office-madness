extends Node

var actor : AnimatedSprite
var speed : float = 70
var state_list =  load("res://actors/proffesor/StateList.gd").new()
var return_state = null
var index : int = 0

func initialize():
	return_state = state_list.State.LOOP
	index = 0
	$IdeaTimer.start()
	
func execute(delta):
	var direction = actor._move(delta, speed)
	
	if !direction.length() and actor.loop_poinst.size():
		actor._navigate(actor.loop_poinst[index])
		index += 1
		
		if index >= actor.loop_poinst.size():
			index = 0
	elif !direction.length():
		return_state = state_list.State.IDLE
	
	return return_state


func _on_IdeaTimer_timeout():
	return_state = state_list.State.IDEA
