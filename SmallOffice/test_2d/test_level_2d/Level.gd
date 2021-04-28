extends Node2D

func _ready() -> void:
	$TestActor2D.initialize(self)
	$TestActor2D/TestFSM2D/States/Move.navigator = $Navigation2D
