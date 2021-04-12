extends Node

var actor : AnimatedSprite
var state_list =  load("res://actors/StateList.gd").new()
var return_state = null

func initialize():
	actor.animation = "idle_down"
	actor.play()
	return_state = state_list.State.IDLE
	$BoredTimer.start()
	
func execute(delta):
	return return_state

func _on_actor_navigate(position):
	return_state = state_list.State.WALK

func _on_BoredTimer_timeout():
	actor.animation = "phone"
	actor.play()

func _on_animation_finished():
	if actor.animation == "phone":
		actor.animation = "idle_down"
		actor.play()
		$BoredTimer.start()
