extends CanvasLayer

@onready var new_game = $MarginMenu/PanelContainer/VBoxContainer/HBoxContainer/VBoxContainer/NewGame as Button
@onready var settings = $MarginMenu/PanelContainer/VBoxContainer/HBoxContainer/VBoxContainer/Settings as Button
@onready var quit = $MarginMenu/PanelContainer/VBoxContainer/HBoxContainer/VBoxContainer/Quit as Button
@onready var settings_ui = $settings_ui as SettingsMenu
@onready var margin_container = $MarginMenu as MarginContainer
var start_level : Node2D

func _ready():
	handle_signals()
	settings_ui.exit_settings.connect(Callable(on_exit_settings_menu))

func on_new_game_pressed() -> void:
	get_tree().change_scene_to_file("res://world.tscn")

func on_settings_pressed() -> void:
	margin_container.visible = false
	settings_ui.set_process(true)
	settings_ui.visible = true

func on_quit_pressed() -> void:
	get_tree().quit()

func on_exit_settings_menu() -> void:
	margin_container.visible = true
	settings_ui.visible = false

func handle_signals() -> void:
	new_game.button_down.connect(on_new_game_pressed)
	settings.button_down.connect(on_settings_pressed)
	quit.button_down.connect(on_quit_pressed)
