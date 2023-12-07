extends CanvasLayer

func _ready():
	get_parent().find_child("Player").gained_diamonds.connect(update_diamonds_value)

func update_health_value(updated_health : int):
	$VBoxContainer/HealthBar.value = updated_health

func update_diamonds_value(_gained_diamonds):
	$HBoxContainer/DiamondDisplay.text = str(get_parent().find_child("Player").diamonds)
