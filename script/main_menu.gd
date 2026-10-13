extends Control


func _on_new_game_pressed() -> void:
	GameManager.is_multiplayer = false
	get_tree().change_scene_to_file("res://scene/main.tscn")


func _on_multplayer_pressed() -> void:
	GameManager.is_multiplayer = true
	get_tree().change_scene_to_file("res://scene/main.tscn")


func _on_fullscreen_pressed() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)


func _on_exit_pressed() -> void:
	get_tree().quit()
