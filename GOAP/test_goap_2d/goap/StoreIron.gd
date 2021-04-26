extends "res://goap/Action.gd"

var target = null

func reset() -> void:
	target = null

func execute(delta : float) -> void:
	if target:
		if !goap.fsm.is_in_range:
			goap.fsm.move()
		else:
			goap.world.get_node("Warehouse").ore_amount += 1
			
			goap.condition_state["stored_iron"] = true
			goap.condition_state["has_iron"] = false
			goap.pop_action()
			
			goap.fsm.pop_state()
			goap.fsm.get_node("Actor").get_node("Ore").hide()
			
	else:
		target = get_tree().get_nodes_in_group("warehouses")[0]
		goap.fsm.target = target.position

func _setpt_up_preconditions() -> void:
	preconditions["has_iron"] = true

func _setpt_up_effects() -> void:
	effects["stored_iron"] = true
