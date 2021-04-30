extends "res://ai/fsm_2d/Move.gd"

var navigator : Navigation2D
var path_2d : Path2D
var path_follow_2d : PathFollow2D

func _ready() -> void:
	path_2d = Path2D.new()
	path_follow_2d = PathFollow2D.new()
	
	path_follow_2d.loop = false
	
	path_2d.add_child(path_follow_2d)
	add_child(path_2d)
	
	speed = 300

func _is_in_range(delta : float) -> bool:
	return is_in_range
	
func _move(delta : float) -> void:
	if path_follow_2d and path_2d.curve.get_baked_points() :
		path_follow_2d.offset += delta*speed
		actor.position = path_follow_2d.position
		
	if path_follow_2d.unit_offset == 1:
		is_in_range = true

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
			
		path_follow_2d.unit_offset = 0.0
			

func _on_area_entered(area : Area2D) -> void:
	var object = area.get_owner()
	
	if object.is_in_group("object") and object.is_in_group("door") and !object.open:
		emit_signal("canceled", object, true)
