extends Camera2D

var speed : float = 5.0
var limit_low : Vector2
var limit_high : Vector2

func _ready():
	limit_low.x = limit_left + 0.5*get_viewport().size.x
	limit_low.y = limit_top + 0.5*get_viewport().size.y
	
	limit_high.x = limit_right - 0.5*get_viewport().size.x
	limit_high.y = limit_bottom - 0.5*get_viewport().size.y

func _process(delta: float) -> void:
	if Input.is_action_pressed('ui_right') and limit_high.x > get_camera_position().x:
		offset_h += delta*speed
	if Input.is_action_pressed('ui_left') and limit_low.x < get_camera_position().x:
		offset_h -= delta*speed
	if Input.is_action_pressed('ui_up') and limit_low.y < get_camera_position().y:
		offset_v -= delta*speed
	if Input.is_action_pressed('ui_down') and limit_high.y > get_camera_position().y:
		offset_v += delta*speed
