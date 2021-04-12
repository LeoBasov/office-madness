extends Node

var rng = RandomNumberGenerator.new()

func _ready():
	var workers = get_tree().get_nodes_in_group("workers")
	var worker_frames = {}
	
	rng.randomize()
	
	worker_frames[0] = load("res://actors/sprites/adam_sprite.tres")
	worker_frames[1] = load("res://actors/sprites/amelia_sprite.tres")
	worker_frames[2] = load("res://actors/sprites/bob_sprite.tres")
	
	for worker in workers:
		var anim_sprite_rand_nr = rng.randi_range(0, worker_frames.size() - 1)
		
		worker.navigator = $Navigation2D
		worker.set_sprite_frames(worker_frames[anim_sprite_rand_nr])
