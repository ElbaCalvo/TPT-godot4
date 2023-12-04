extends Node2D

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		var loading_screen = get_node("/root/Main/World1/level_transition")
		area.get_parent().can_move = false
		loading_screen.change_level()
		queue_free()

