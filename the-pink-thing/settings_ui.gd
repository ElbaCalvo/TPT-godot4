class_name SettingsMenu

extends CanvasLayer

@onready var exit_button = $MarginContainer/VBoxContainer/ExitButton as Button

signal exit_settings

func _redy():
	exit_button.button_down.connect(on_exit_pressed)
	set_process(false)

func on_exit_pressed() -> void:
	exit_settings.emit()
	set_process(false)
