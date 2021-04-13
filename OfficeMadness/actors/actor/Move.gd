extends Node

var animated_sprite : AnimatedSprite
var actor : Node2D
var speed : float = 100.0
var target_post : Vector2

func _ready():
	animated_sprite = get_owner().get_node("AnimatedSprite")
	actor = get_owner()

func initialize() -> void:
	var path = $Navigation2D.get_simple_path(actor.position, target_post)

	if path.size():
		$Path2D.curve.clear_points()
		$Path2D.curve.add_point(actor.position)
		
		for point in path:
			$Path2D.curve.add_point(point)
			
		$Path2D/PathFollow2D.unit_offset = 0.0

func execute(delta) -> bool:
	var direction = _move(delta, speed)
	_animate(direction)
	
	return !direction.length()
	
func _move(delta : float, speed : float) -> Vector2:
	var direction = Vector2()
	
	if $Path2D/PathFollow2D and $Path2D.curve.get_baked_points() :
		$Path2D/PathFollow2D.offset += delta*speed
		direction = $Path2D/PathFollow2D.position - actor.position
		actor.position = $Path2D/PathFollow2D.position
		
	return direction

func _animate(direction : Vector2) -> void:
	if (direction.angle() <= PI and direction.angle() >= 3*PI/4) or (direction.angle() >= -PI and direction.angle() <= -3*PI/4):
		animated_sprite.animation = "run_left"
		animated_sprite.play()
	elif direction.angle() <= 3*PI/4 and direction.angle() >= PI/4:
		animated_sprite.animation = "run_down"
		animated_sprite.play()
	elif direction.angle() >= -3*PI/4 and direction.angle() <= -PI/4:
		animated_sprite.animation = "run_up"
		animated_sprite.play()
	elif (direction.angle() >= 0 and direction.angle() <= 3*PI/4) or (direction.angle() <= 0 and direction.angle() >= -3*PI/4):
		animated_sprite.animation = "run_right"
		animated_sprite.play()
