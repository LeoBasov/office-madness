extends Camera2D

func _process(delta: float) -> void:
	if Input.is_action_pressed('ui_right'):
		offset += delta*Vector2(100, 0)
	if Input.is_action_pressed('ui_left'):
		offset -= delta*Vector2(100, 0)
	if Input.is_action_pressed('ui_up'):
		offset += delta*Vector2(0, 100)
	if Input.is_action_pressed('ui_down'):
		offset -= delta*Vector2(0, 100)
