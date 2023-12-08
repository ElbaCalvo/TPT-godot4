extends Control

var user_prefs: UserPreferences

func _ready() -> void:
	user_prefs = SettingsSignalBus.load_or_create()
	$HBoxContainer/LineEdit.text = SettingsSignalBus.settings["username"]
	_on_line_edit_text_submitted($HBoxContainer/LineEdit.text)
	
func _on_line_edit_text_submitted(new_text):
	$HBoxContainer/LineEdit.text = new_text
	SettingsSignalBus.emit_on_username_changed(new_text)
