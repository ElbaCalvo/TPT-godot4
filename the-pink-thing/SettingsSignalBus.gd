extends Node2D

var settings = {
	"window_mode_index": 0,
	"resolution_index": 0,
	"music_volume": 0.5,
	"sfx_volume": 0.5,
	#"username": "Addam"
}
func _ready():
	load_or_create()

func save_settings():
	var user_prefs = UserPreferences.new()
	user_prefs.window_mode_index = settings["window_mode_index"]
	user_prefs.resolution_index = settings["resolution_index"]
	user_prefs.music_volume = settings["music_volume"]
	user_prefs.sfx_volume = settings["sfx_volume"]
	#user_prefs.username = settings["username"]
	ResourceSaver.save(user_prefs, "user://user_prefs.tres")
	print("resolution: ", user_prefs.resolution_index)

func load_or_create():
	if ResourceLoader.exists("user://user_prefs.tres"):
		var user_prefs = ResourceLoader.load("user://user_prefs.tres") as UserPreferences
		settings["window_mode_index"] = user_prefs.window_mode_index
		settings["resolution_index"] = user_prefs.resolution_index
		settings["music_volume"] = user_prefs.music_volume
		settings["sfx_volume"] = user_prefs.sfx_volume
		#settings["username"] = user_prefs.username
		print("resolution: ", settings["resolution_index"])
	else:
		save_settings()

func emit_on_window_changed(index: int):
	settings["window_mode_index"] = index
	save_settings()

func emit_on_resolution_changed(index: int):
	settings["resolution_index"] = index
	save_settings()

func emit_on_sfx_changed(value: float):
	settings["sfx_volume"] = value
	save_settings()

func emit_on_music_changed(value: float):
	settings["music_volume"] = value
	save_settings()

#func emit_on_username_changed(username: String):
	#settings["username"] = username
	#save_settings()
