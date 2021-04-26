extends "res://goap/Action.gd"

var target = null

func _ready() -> void:
	cost = 3

func reset() -> void:
	target = null

func execute(delta : float) -> void:
	if goap.condition_state["ore_availible"] and !goap.condition_state["has_iron"]:
		_get_iron(delta)
	elif goap.condition_state["has_iron"]:
		_smith(delta)
	else:
		emit_signal("canceled")
		
func _get_iron(delta : float) -> void:
	if target == null and goap.world.get_node("Warehouse"):
		target = goap.world.get_node("Warehouse")
		goap.fsm.target = target.position
		
	elif target and goap.world.get_node("Warehouse"):
		if !goap.fsm.is_in_range:
			goap.fsm.move()
		else:
			goap.fsm.get_node("Actor").get_node("Ore").show()
			goap.world.get_node("Warehouse").ore_amount -= 1
			goap.condition_state["has_iron"] = true
			goap.fsm.pop_state()
			target = null
	else:
		emit_signal("canceled")
	
func _smith(delta : float) -> void:
	if target == null and goap.world.get_node("Wrough"):
		target = goap.world.get_node("Wrough")
		goap.fsm.target = target.position
		
	elif target and goap.world.get_node("Wrough"):
		if !goap.fsm.is_in_range:
			goap.fsm.move()
		else:
			goap.fsm.get_node("Actor").get_node("Ore").hide()
			goap.fsm.get_node("Actor").get_node("Axe").show()
			goap.condition_state["has_iron"] = true
			goap.condition_state["has_axe"] = true
			goap.fsm.pop_state()
			goap.pop_action()
			target = null
	else:
		emit_signal("canceled")

func _setpt_up_preconditions() -> void:
	preconditions["ore_availible"] = true
	preconditions["has_axe"] = false

func _setpt_up_effects() -> void:
	effects["has_axe"] = true
