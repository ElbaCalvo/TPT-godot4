extends Node2D

func _ready():
	$AnimatedSprite2D.play("idle")
	
func _on_area_2d_area_entered(body):
	if body.get_parent() is Player:
		get_node("/root/Main").gain_diamonds(1)
		$AnimatedSprite2D.play("collected")
		await get_tree().create_timer(0.75).timeout
		queue_free()
