extends Node

var actor : AnimatedSprite
var state_list =  load("res://actors/worker/StateList.gd").new()
var return_state = null
var speed : float = 100

func initialize():
	return_state = state_list.State.WORK
	
func execute(delta):
	var direction = actor._move(delta, speed)
	
	return return_state

func _on_object_selected(object):
	if actor.selected:
		var pos = object.position
		
		pos.y -= 50
		return_state = state_list.State.WORK
		actor.navigate(pos)
