extends "res://ai/fsm_2d/Move.gd"

var navigator : Navigation2D
var path_2d : Path2D
var path_follow_2d : PathFollow2D

func _is_in_range(delta : float) -> bool:
	return is_in_range
	
func _move(delta : float) -> void:
	if path_follow_2d and path_2d.curve.get_baked_points() :
		path_follow_2d.offset += delta*speed
		actor.position = path_follow_2d.position

func set_target(new_target : Vector2) -> void:
	.set_target(new_target)
	_navigate(new_target)
	
func _navigate(new_position : Vector2) -> void:
	var path = navigator.get_simple_path(actor.position, new_position)

	if path.size():
		path_2d.curve.clear_points()
		path_2d.curve.add_point(actor.position)
		
		for point in path:
			path_2d.curve.add_point(point)
			

func _on_area_entered(area : Area2D) -> void:
	if area.is_in_group("object") and area.is_in_group("key"):
		is_in_range = true
