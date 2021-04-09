extends Node

func _ready():
	$Worker.navigator = $Navigation2D

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			$Worker.navigate(event.position)
