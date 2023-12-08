extends Node2D

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		get_parent().find_child("game_over_screen").set_title(true)
		get_parent().find_child("Player").queue_free()
		get_parent().send_post_new_score(SettingsSignalBus.settings["username"], self.get_parent().find_child("Player").diamonds)
