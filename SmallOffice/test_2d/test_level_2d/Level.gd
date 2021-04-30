extends Node2D

func _ready() -> void:
	$TestActor2D.initialize(self)
	$TestActor2D/TestFSM2D/States/Move.navigator = $Navigation2D

func _process(delta: float) -> void:
	var goal_string : String = "GOAL\n====\n"
	var plan_string : String = "GLAN\n====\n"
	var stack = $TestActor2D/TestGOAP2D.action_stack.duplicate()
	
	stack.invert()
	
	for action in stack:
		plan_string += action.name
		plan_string += "\n"
	
	goal_string += $TestActor2D/TestGOAP2D.current_goal
	
	$Goal.text = goal_string
	$Plan.text = plan_string
