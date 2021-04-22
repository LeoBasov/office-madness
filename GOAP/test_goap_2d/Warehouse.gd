extends Sprite

var ore_amount : int = 0

func _process(delta: float) -> void:
	$Label.text = String(ore_amount)
