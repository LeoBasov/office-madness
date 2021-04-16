extends Node

var actor : AnimatedSprite
var state_list =  load("res://actors/proffesor/StateList.gd").new()
var return_state = null
var rng = RandomNumberGenerator.new()
var speed : float = 200
var hunt_worker

func _ready():
	rng.randomize()

func initialize():
	var rand_nr = rng.randi_range(0, actor.worker_list.size() - 1)
	
	actor.animation = "idle_down"
	actor.play()
	return_state = state_list.State.HUNT
	
	hunt_worker = actor.worker_list[rand_nr]
	
	while !hunt_worker:
		rand_nr = rng.randi_range(0, actor.worker_list.size() - 1)
		hunt_worker = actor.worker_list[rand_nr]
	
func execute(delta):
	if hunt_worker:
		actor._navigate(hunt_worker.position)
		var direction = actor._move(delta, speed)
	
		if !direction.length():
			return_state = state_list.State.LOOP
	else:
		return_state = state_list.State.LOOP
	
	return return_state

func _on_Area2D_area_entered(area):
	if area.get_owner().is_in_group("workers") and actor.get_node("FSM").current_state == actor.get_node("FSM").state_list.State.HUNT:
		return_state = state_list.State.LOOP
