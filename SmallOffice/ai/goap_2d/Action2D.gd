extends "res://ai/goap/Action.gd"

var target = null

# OVERRIDE THESE
#===============================================================================
func _target_exists() -> bool:
	return false

func _get_target() -> void:
	pass

func _execute_action() -> void:
	pass
#===============================================================================

func execute(delta : float) -> void:
	if target == null and _target_exists():
		_get_target()
		fsm.target = target.position
	elif target and _target_exists():
		if !fsm.is_in_range:
			fsm.move()
		else:
			_execute_action()
	else:
		pass
