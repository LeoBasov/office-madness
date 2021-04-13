extends Node2D

var states : Dictionary = {}
var state_stack : Array = []
var state_index : int = 0
var default_state = null

func _ready():
	default_state = $States/Default
	default_state.initialize()

func _process(delta):
	if state_index < state_stack.size():
		var done : bool = states[state_stack[state_index]].execute(delta)

		if done:
			state_index += 1
			
			if state_index >= state_stack.size():
				default_state.initialize()
			else:
				states[state_stack[state_index]].initialize()
	else:
		default_state.execute(delta)

func set_nav_polygon(nav_poly_instance : NavigationPolygonInstance):
	$NavigationPolygonInstance.navpoly = nav_poly_instance.navpoly
