extends MarginContainer

var increment : float = 1.0
var speed : float = 0.0
var value : float = 0.0

func _process(delta):
	value += delta*speed
	$HBoxContainer/TextureProgress.value = value

func _on_worker_add(value):
	if value:
		speed += increment
	else:
		speed -= increment
