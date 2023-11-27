extends Node2D
var healthy: int
func _ready():
	$AnimatedSprite2D.play("idle")
	
func _on_area_2d_area_entered(area):	
	if area.get_parent() is Player:
		var player = get_node("/root/Main/World1/Player")
		if (player.actual_health < 100) or (player.health < 100):
			player.actual_health += 10
			player.health += 10
		$AnimatedSprite2D.play("collected")
		await get_tree().create_timer(0.75).timeout
		update_ui(player.actual_health)
		queue_free()
		
func update_ui(actual_health):
	var gui = get_node("/root/Main/World1/GUI")
	var player = get_node("/root/Main/World1/Player")
	
	gui.update_health_value(player.actual_health)
