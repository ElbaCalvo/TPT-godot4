extends CanvasLayer

@onready var title = $MarginMenu/PanelContainer/VBoxContainer/Title

func _ready():
	$".".visible = false

func set_title(win: bool):
	if win:
		title.text = "YOU WIN!!"
	else:
		title.text = "GAME OVER..."
	$".".visible = true

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://ui.tscn")

func _on_exit_button_pressed():
	get_tree().quit()
