extends AnimatedSprite

var path_2d : Path2D
var path_follow_2d : PathFollow2D
var navigator : Navigation2D

signal navigate(position)

func _ready():
	path_2d = Path2D.new()
	path_follow_2d = PathFollow2D.new()
	
	path_follow_2d.loop = false
	
	path_2d.add_child(path_follow_2d)
	add_child(path_2d)
	
	$FSM.set_actor(self)
	
func _process(delta):
	$FSM.execute(delta)
	
func navigate(new_position):
	emit_signal("navigate", new_position)

func _navigate(new_position):
	var path = navigator.get_simple_path(position, new_position)

	if path.size():
		path_2d.curve.clear_points()
		path_2d.curve.add_point(position)
		
		for point in path:
			path_2d.curve.add_point(point)
			
		path_follow_2d.unit_offset = 0.0

func _move(delta : float, speed : float) -> Vector2:
	var direction = Vector2()
	
	if path_follow_2d and path_2d.curve.get_baked_points() :
		path_follow_2d.offset += delta*speed
		direction = path_follow_2d.position - position
		position = path_follow_2d.position
		
	if (direction.angle() <= PI and direction.angle() >= 3*PI/4) or (direction.angle() >= -PI and direction.angle() <= -3*PI/4):
		animation = "run_left"
		play()
	elif direction.angle() <= 3*PI/4 and direction.angle() >= PI/4:
		animation = "run_down"
		play()
	elif direction.angle() >= -3*PI/4 and direction.angle() <= -PI/4:
		animation = "run_up"
		play()
	elif (direction.angle() >= 0 and direction.angle() <= 3*PI/4) or (direction.angle() <= 0 and direction.angle() >= -3*PI/4):
		animation = "run_right"
		play()
		
	return direction
