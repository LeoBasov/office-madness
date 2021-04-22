extends Node

var ready : bool = true
var Fiel = preload("res://test_goap_2d/level/Field.tscn")

func _ready() -> void:
	$GOAPAgent.initialize(self)
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed('ui_select'):
		$GOAPAgent._action_canceled()

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
