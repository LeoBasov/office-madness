extends "res://actors/Actor.gd"

var mouse_over : bool = false
var selected : bool = false

func _ready():
	._ready()
	$SelectIcon.play()
	$SelectIcon.hide()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed and mouse_over:
			selected = true
			$SelectIcon.show()
		elif event.button_index == BUTTON_LEFT and event.pressed and !mouse_over:
			selected = false
			$SelectIcon.hide()

func _on_Area2D_mouse_entered():
	mouse_over = true


func _on_Area2D_mouse_exited():
	mouse_over = false
