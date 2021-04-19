extends MarginContainer

signal finished

var increment : float = 1.0
var speed : float = 0.0
var value : float = 0.0

func _process(delta):
	value += delta*speed
	$VBoxContainer/HBoxContainer/TextureProgress.value = value
	
	if $VBoxContainer/HBoxContainer/TextureProgress.value == 100:
		emit_signal("finished")

func _on_worker_add(value):
	if value:
		speed += increment
	else:
		speed -= increment
