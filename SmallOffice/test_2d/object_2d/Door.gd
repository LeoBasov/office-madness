extends Node2D

export var open : bool = false

func _ready() -> void:
	if open:
		$AnimatedSprite.animation = "open"
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.animation = "closed"
		$AnimatedSprite.play()
