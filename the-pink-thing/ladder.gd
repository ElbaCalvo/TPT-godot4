extends Node2D

func _on_area_2d_body_entered(body):
	if body.is_in_group("player_group"):
		var player = get_parent().find_child("Player")
		if player.climbing == false:
			player.climbing = true
			
func _on_area_2d_body_exited(body):
	if body.is_in_group("player_group"):
		var player = get_parent().find_child("Player")
		if player.climbing == true:
			player.climbing = false
