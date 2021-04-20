extends "res://actors/Actor.gd"

signal remove_worker
signal add_worker

var mouse_over : bool = false
var selected : bool = false
var lifes : int = 3

func _ready():
	._ready()
	$SelectIcon.play()
	$SelectIcon.hide()
	
	$Reaction.play()
	
	$Effect.object = self

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed and mouse_over:
			selected = true
			$SelectIcon.show()
		elif event.button_index == BUTTON_LEFT and event.pressed and !mouse_over:
			selected = false
			$SelectIcon.hide()
		elif event.button_index == BUTTON_RIGHT and event.pressed and selected:
			navigate(event.position)

func _on_Area2D_mouse_entered():
	mouse_over = true
	
	if !selected:
		$Effect.effect_type = $Effect.Type.BLINCK

func _on_Area2D_mouse_exited():
	mouse_over = false
	$Effect.reset()

func _on_object_selected(object):
	if selected:
		var pos = object.position
		
		pos.y -= 50
		navigate(pos)
		$FSM/Walk.work = true


func _on_Ord_dead():
	queue_free()

func _on_Area2D_area_entered(area):
	if area.get_owner().is_in_group("proffesor") and area.get_owner().get_node("FSM").current_state == area.get_owner().get_node("FSM").state_list.State.HUNT:
		if lifes == 3:
			$Reaction.play()
			$Reaction.show()
			lifes -= 1
		elif lifes == 2:
			$Reaction.play()
			$Reaction.show()
			lifes -= 1
		elif lifes == 1:
			$Reaction.play()
			$Reaction.show()
			lifes -= 1
		elif lifes == 0:
			queue_free()


func _on_Reaction_animation_finished():
	$Reaction.hide()
	$Reaction.stop()
