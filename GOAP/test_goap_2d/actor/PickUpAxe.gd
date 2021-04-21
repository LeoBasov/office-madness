extends "res://actor_2d/State2d.gd"

func execute(delta : float) -> void:
	print("PICK UP AXE")
	fsm.pop_state()
	fsm.push_state(fsm.get_node("States").get_node("Mine"))
