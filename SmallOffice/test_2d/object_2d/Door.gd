extends Node2D

export var open : bool = false setget set_open

func _ready() -> void:
	if open:
		$AnimatedSprite.animation = "open"
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.animation = "closed"
		$AnimatedSprite.play()

func set_open(value : bool) -> void:
	open = value
	
	if open:
		$AnimatedSprite.animation = "open"
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.animation = "closed"
		$AnimatedSprite.play()
