extends "res://actors/Actor.gd"

var mouse_over : bool = false
var selected : bool = false

func _ready():
	._ready()
	$SelectIcon.play()
	$SelectIcon.hide()
	
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
