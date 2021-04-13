extends Node

var rng = RandomNumberGenerator.new()

func assemble_navi_points():
	var points = []
	
	points.push_back($Pos1.position)
	points.push_back($Pos2.position)
	points.push_back($Pos3.position)
	points.push_back($Pos4.position)
	points.push_back($Pos5.position)
	points.push_back($Pos6.position)
	
	return points

func _ready():
	var workers = get_tree().get_nodes_in_group("workers")
	var objects = get_tree().get_nodes_in_group("objects")
	var worker_frames = {}
	
	rng.randomize()
	
	worker_frames[0] = load("res://actors/sprites/adam_sprite.tres")
	worker_frames[1] = load("res://actors/sprites/amelia_sprite.tres")
	worker_frames[2] = load("res://actors/sprites/bob_sprite.tres")
	
	for worker in workers:
		var anim_sprite_rand_nr = rng.randi_range(0, worker_frames.size() - 1)
		
		worker.navigator = $Navigation2D
		worker.set_sprite_frames(worker_frames[anim_sprite_rand_nr])
		worker.connect("add_worker", $UI, "_on_worker_add")
		
		for object in objects:
			object.connect("selected", worker, "_on_object_selected")

	$YSort/Professor.navigator = $Navigation2D
	$YSort/Professor.loop_poinst = assemble_navi_points()
	$YSort/Professor.worker_list = workers
