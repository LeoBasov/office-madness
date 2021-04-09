extends "res://actors/BaseFMS.gd"

var actor : AnimatedSprite
var speed : float = 100

func initialize():
	return_state = State.WALK
	# load and play animation
	
func execute(delta):
	var direction = actor._move(delta, speed)
	
	if !direction.length():
		return_state = State.IDLE
	elif (direction.angle() <= PI and direction.angle() >= 3*PI/4) or (direction.angle() >= -PI and direction.angle() <= -3*PI/4):
		actor.animation = "run_left"
		actor.play()
	elif direction.angle() <= 3*PI/4 and direction.angle() >= PI/4:
		actor.animation = "run_down"
		actor.play()
	elif direction.angle() >= -3*PI/4 and direction.angle() <= -PI/4:
		actor.animation = "run_up"
		actor.play()
	elif (direction.angle() >= 0 and direction.angle() <= 3*PI/4) or (direction.angle() <= 0 and direction.angle() >= -3*PI/4):
		actor.animation = "run_right"
		actor.play()
	
	return return_state

func _on_actor_navigate(position):
	actor._navigate(position)
