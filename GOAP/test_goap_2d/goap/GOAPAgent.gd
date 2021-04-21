extends "res://goap/GOAP.gd"

func _ready() -> void:
	._ready()
	fsm = $Dwarf

	$Dwarf/States/Walk.target = Vector2(500, 500)
