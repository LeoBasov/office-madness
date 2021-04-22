extends "res://goap/Action.gd"

var target = null
var walk_state

func _ready() -> void:
	cost = 3

func reset() -> void:
	target = null
	walk_state = goap.fsm.get_node("States").get_node("Walk")

func execute(delta : float) -> void:
	if goap.world.get_node("Warehouse") and goap.condition_state["ore_availible"] == true and goap.condition_state["has_iron"] == false:
		target = goap.world.get_node("Warehouse")
		walk_state.target = target.position
		
		if (target.position - goap.fsm.get_node("Actor").position).length() > walk_state.speed:
			goap.fsm.pop_state()
			goap.fsm.push_state(walk_state)
		else:
			goap.fsm.get_node("Actor").get_node("Ore").show()
			goap.world.get_node("Warehouse").ore_amount -= 1
			goap.condition_state["has_iron"] = true
			goap.fsm.pop_state()
		
	elif goap.world.get_node("Wrough") and goap.condition_state["has_iron"] == true:
		target = goap.world.get_node("Wrough")
		walk_state.target = target.position
		
		if (target.position - goap.fsm.get_node("Actor").position).length() > walk_state.speed:
			goap.fsm.pop_state()
			goap.fsm.push_state(walk_state)
		else:
			goap.fsm.get_node("Actor").get_node("Ore").hide()
			goap.fsm.get_node("Actor").get_node("Axe").show()
			goap.condition_state["has_iron"] = true
			goap.condition_state["has_axe"] = true
			goap.fsm.pop_state()
			goap.pop_action()
		
	else:
		emit_signal("canceled")

func _setpt_up_preconditions() -> void:
	preconditions["ore_availible"] = true
	preconditions["has_axe"] = false

func _setpt_up_effects() -> void:
	effects["has_axe"] = true
