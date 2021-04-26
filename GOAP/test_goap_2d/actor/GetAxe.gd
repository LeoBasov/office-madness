extends "res://fsm_2d/State2d.gd"

func execute(delta : float) -> void:
	fsm.axe_life = 3
	fsm.get_node("Actor").get_node("Axe").show()
	fsm.pop_state()
