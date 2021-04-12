extends "res://actors/Idle.gd"

func initialize():
	.initialize()
	$BoredTimer.start()

func _on_BoredTimer_timeout():
	actor.animation = "phone"
	actor.play()

func _on_Worker_animation_finished():
	if actor.animation == "phone":
		actor.animation = "idle_down"
		actor.play()
		$BoredTimer.start()
