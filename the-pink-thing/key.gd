extends Node2D

func _ready():
	$AnimatedSprite2D.play("idle")
	
func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		area.get_parent().can_move = false
		get_parent().find_child("level_transition").change_level()
		queue_free()
