extends Control


func _on_play_pressed():
	#Trans.trans_scene()
	get_tree().change_scene_to_file("res://Scenes/BedRoom.tscn")


func _on_quit_pressed():
	get_tree().quit()


func _on_options_pressed():
	get_tree().change_scene_to_file("res://Scenes/options.tscn")
