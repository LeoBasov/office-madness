extends Node

var animated_sprite : AnimatedSprite
var actor : Node2D

func _ready():
	animated_sprite = get_owner().get_node("AnimatedSprite")
	actor = get_owner()
	
	print(actor)

func initialize():
	animated_sprite.animation = "idle_down"
	animated_sprite.play()

func execute(delta):
	return true
