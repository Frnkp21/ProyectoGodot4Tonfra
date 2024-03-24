extends Node2D
@export var player : CharacterBody2D

func _ready():
	player.position = global.posicion
	var camera = $player/Camera2D
	camera.set_zoom(global.zoom)


func _process(delta):
	pass
