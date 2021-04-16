extends Node2D

var mouse_over : bool = false
var selected : bool = false

signal selected(value)
signal add_worker(value)

func _ready():
	$Effect.object = self

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_RIGHT and event.pressed and mouse_over:
			emit_signal("selected", self)

func _on_Area2D_mouse_entered():
	mouse_over = true
	
	if !selected:
		$Effect.effect_type = $Effect.Type.BLINCK

func _on_Area2D_mouse_exited():
	mouse_over = false
	$Effect.reset()

func _on_Area2D_area_entered(area):
	if area.get_owner().is_in_group("workers"):
		emit_signal("add_worker", true)

func _on_Area2D_area_exited(area):
	if !area:
		emit_signal("add_worker", false)
	elif !area.get_owner():
		emit_signal("add_worker", false)
	elif area.get_owner().is_in_group("workers"):
		emit_signal("add_worker", false)
