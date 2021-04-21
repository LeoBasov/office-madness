extends "res://actor_2d/State2d.gd"

var idle_state  : Node

func initialize(new_fsm :  Node) -> void:
	.initialize(new_fsm)
	idle_state = new_fsm.get_node("States").get_node("Idle")

func execute(delta : float) -> void:
	actor.position += Vector2(1.0, 1.0)
	
	if actor.position.x > 150:
		fsm.push_state(idle_state)
		fsm.pop_state()
