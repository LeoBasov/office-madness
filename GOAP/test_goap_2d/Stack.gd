extends Sprite

var axe_amount : int = 1

func _process(delta: float) -> void:
	$Label.text = String(axe_amount)
