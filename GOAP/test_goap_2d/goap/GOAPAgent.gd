extends "res://goap/GOAP.gd"

var state_get_iron
var state_get_axe

func _ready() -> void:
	._ready()
	fsm = $Dwarf
	state_get_iron = $Dwarf/States/Mine
	state_get_axe = $Dwarf/States/PickUpAxe

	$Dwarf/States/Walk.target = Vector2(500, 500)

func _set_up() -> void:
	condition_state["has_axe"] = false
	condition_state["has_iron"] = false

