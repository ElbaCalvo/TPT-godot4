extends CanvasLayer

func _ready():
	get_node("/root/Main").gained_diamonds.connect(update_diamonds_value)

func update_health_value(updated_health : int):
	$VBoxContainer/HealthBar.value = updated_health

func update_diamonds_value(_gained_diamonds):
	$HBoxContainer/DiamondDisplay.text = str(get_node("/root/Main").diamonds)
