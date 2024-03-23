extends Node2D
@export var player : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	player.position = Coordenadas.posicion
	var camera = $player/Camera2D
	camera.set_zoom(Coordenadas.zoom)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#func _on_forest_transition_point_body_entered(body):
	#if body.has_method("player"):
	#	global.transition_scene = destino


#func _on_forest_transition_point_body_exited(body):
	#if body.has_method("player"):
	#	global.transition_scene = desti
		

#func change_scene():
	#if global.transition_scene == true:
	#	if global.current_scene == "Street":
		#	get_tree().change_scene_to_file("res://Scenes/Forest.tscn")
		#	global.finish_changescenes()


