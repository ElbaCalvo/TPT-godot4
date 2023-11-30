extends Node2D

func _ready():
	$AnimatedSprite2D.play("idle")
	
func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		get_tree().change_scene_to_file("res://world_2.tscn")
