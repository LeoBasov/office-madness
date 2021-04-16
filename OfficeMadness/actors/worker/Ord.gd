extends Sprite

signal dead

var lifes : int = 3

func _ready():
	hide()

func _on_Area2D_area_entered(area):
	if area.get_owner().is_in_group("proffesor") and area.get_owner().get_node("FSM").current_state == area.get_owner().get_node("FSM").state_list.State.HUNT:
		if lifes == 3:
			show()
			modulate = Color(0, 1, 0)
			lifes -= 1
		elif lifes == 2:
			modulate = Color(1, 1, 0)
			lifes -= 1
		elif lifes == 1:
			modulate = Color(1, 0, 0)
			lifes -= 1
		elif lifes == 0:
			emit_signal("dead")
