extends Control

var positionHome = Vector2(-79, -2)
var zoomHome = Vector2(4.5,4.5)
var sceneHome = "res://Scenes/BedRoom.tscn"

func _on_respawn_pressed():
	global.posicion = global.lastPositon
	global.zoom = global.lastZoom
	global.hpProtagonista = 100
	get_tree().change_scene_to_file(global.lastScene)
	return

func _on_respawn_home_pressed():
	global.posicion = positionHome
	global.zoom = zoomHome
	global.hpProtagonista = 100
	get_tree().change_scene_to_file(sceneHome)
	return
