extends CanvasLayer

func _ready():
	pass

func update_health_value(updated_health : int):
	$VBoxContainer/HealthBar.value = updated_health
