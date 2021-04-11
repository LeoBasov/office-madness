extends Node

enum Type {NONE = 0, BLINCK = 1}

var object = null
export var effect_type = Type.NONE

var factor : float = 1.0
var val : float = 0.0
export var max_mod : float = 1.0
export var min_mod : float = 0.5
export var blink_speed : float = 0.5

func _process(delta):
	if object and effect_type == Type.BLINCK:
		val += delta*factor*blink_speed
	
		if val > max_mod:
			val = max_mod
			factor = -1.0
		elif val < min_mod:
			val = min_mod
			factor = 1.0
	
		object.modulate = Color(val,val,val)
