extends Node

func _ready():
	var workers = get_tree().get_nodes_in_group("workers")
	
	for worker in workers:
		worker.navigator = $Navigation2D
