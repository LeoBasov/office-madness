extends Node

var ready : bool = true
var Fiel = preload("res://test_goap_2d/level/Field.tscn")

func _ready() -> void:
	$Miner.initialize(self)
	
	var text = "POSSIBLE ACTIONS\n"
	text += "================\n"
	
	for action in $Miner/Actions.get_children():
		text += action.name + "\n"
		
	$PossibleActions.text = text
	
# warning-ignore:unused_argument
func _process(delta: float) -> void:
	if Input.is_action_just_pressed('ui_select'):
		get_tree().paused = !get_tree().paused
		
	var text = ""
	var stack = $Miner.action_stack.duplicate(true)
	
	stack.invert()
	
	for action in stack:
		text += action.name + "\n"
		
	$ActionStack.text = text
	$Goal.text = $Miner.current_goal + " " + String($Miner.goals[$Miner.current_goal])

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed and ready:
			ready = false
			var field = Fiel.instance()
			field.position = event.position
			add_child(field)
			$ClickTimer.start()


func _on_ClickTimer_timeout() -> void:
	ready = true
