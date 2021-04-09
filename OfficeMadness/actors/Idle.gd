extends "res://actors/BaseFMS.gd"

var actor : AnimatedSprite

func initialize():
	actor.animation = "idle_down"
	actor.play()
	return_state = State.IDLE
	$BoredTimer.start()
	
func execute(delta):
	return return_state

func _on_actor_navigate(position):
	return_state = State.WALK


func _on_BoredTimer_timeout():
	actor.animation = "phone"
	actor.play()

func _on_animation_finished():
	if actor.animation == "phone":
		actor.animation = "idle_down"
		actor.play()
		$BoredTimer.start()
