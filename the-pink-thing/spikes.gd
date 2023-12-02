extends Node2D

func _on_area_2d_body_entered(body):
	if body.is_in_group("player_group"):
		print("tocando pinchos")
		var player = get_node("/root/Main/World1/Player")
		player.hit()
		#player.queue_free()
