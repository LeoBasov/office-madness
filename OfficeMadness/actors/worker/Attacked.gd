extends Node

var actor : AnimatedSprite
var state_list =  load("res://actors/worker/StateList.gd").new()
var return_state = null
var speed : float = 100
var old_position : Vector2
var reaction : bool
var animation : bool

func initialize():
	actor.get_node("Reaction").play()
	actor.get_node("Reaction").show()
	
	actor.animation = "idle_down"
	actor.play()
	
	old_position = actor.position
	
	$AnimationPlayer.play("level1")
	
	return_state = state_list.State.ATTACKED
	
	reaction = true
	animation = true
	
func execute(delta):
	if animation:
		actor.position += old_position
	
	if !reaction and !animation:
		return_state = state_list.State.IDLE
	
	return return_state

func _on_Reaction_animation_finished():
	actor.get_node("Reaction").stop()
	actor.get_node("Reaction").hide()
	
	reaction = false


func _on_AnimationPlayer_animation_finished(anim_name):
	$AnimationPlayer.stop()
	actor.position = old_position
	animation = false
