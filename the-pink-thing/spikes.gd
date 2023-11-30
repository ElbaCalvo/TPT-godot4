extends Node2D

func _on_body_entered(body):
	print("Tocando pinchos")
	if body.is_in_group("player_group"):
		var player = get_node("/root/Main/World1/Player")
		player.die()
		queue_free()
