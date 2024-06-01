extends Control

var playerZoomOut = Vector2(3,3)
var playerZoomIn = Vector2(4.5,4.5)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_volver_pressed():
	if (global.pausaopen):
		var path = global.pathPause
		global.posicion = global.playerPosition
		if (path == "BedRoom" or path == "Hallway" or path == "Bathroom" or path == "Parentsroom" or path == "Livingroom" or path == "BedRoom2" or path == "Hallway2" or path == "Bathroom2" or path == "Parentsroom2" or path == "Livingroom2"):
			get_tree().change_scene_to_file("res://Scenes/" + path + ".tscn")
			global.zoom = playerZoomIn
		else:
			get_tree().change_scene_to_file("res://Scenes/" + path + ".tscn")
			global.zoom = playerZoomOut
	else:
		get_tree().change_scene_to_file("res://Scenes/menu.tscn")
