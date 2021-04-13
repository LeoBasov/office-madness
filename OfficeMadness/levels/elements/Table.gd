extends Node2D

var mouse_over : bool = false
var selected : bool = false

func _ready():
	$Effect.object = self


func _on_Area2D_mouse_entered():
	mouse_over = true
	
	if !selected:
		$Effect.effect_type = $Effect.Type.BLINCK

func _on_Area2D_mouse_exited():
	mouse_over = false
	$Effect.reset()
