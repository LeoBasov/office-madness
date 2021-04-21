extends "res://actor_2d/State2d.gd"

var world

func execute(delta : float) -> void:
	print("Mine")
	
	fsm.get_node("Actor").get_node("Axe").show()
	
	fsm.get_node("States").get_node("Walk").target = get_tree().get_nodes_in_group("fields")[0].position
	
	fsm.pop_state()
	fsm.push_state(fsm.get_node("States").get_node("Walk"))
