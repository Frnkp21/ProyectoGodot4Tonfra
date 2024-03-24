extends Control

@export var target_position: Vector2
@export var target_scene: String
@export var target_zoom: Vector2



func _on_respawn_pressed():
	global.posicion = target_position
	global.zoom = target_zoom
	get_tree().change_scene_to_file("res://Scenes/" + target_scene + ".tscn")
	return
