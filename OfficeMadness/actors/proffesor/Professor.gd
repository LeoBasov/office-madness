extends "res://actors/Actor.gd"

var path_loop_2d : Path2D
var path_follow_loop_2d : PathFollow2D

func _ready():
	._ready()

	path_loop_2d = Path2D.new()
	path_follow_loop_2d = PathFollow2D.new()
	
	path_follow_loop_2d.loop = false
	
	path_loop_2d.add_child(path_follow_loop_2d)
	add_child(path_loop_2d)
