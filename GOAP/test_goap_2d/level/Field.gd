extends Sprite

var mouse : bool = false

func _on_Area2D_mouse_entered() -> void:
	mouse = true

func _on_Area2D_mouse_exited() -> void:
	mouse = false

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_RIGHT and event.pressed and mouse:
			queue_free()
