extends Node2D
@export var player : CharacterBody2D

func _ready():
	player.position = global.posicion
	var camera = $player/Camera2D
	camera.set_zoom(global.zoom)


func _process(delta):
	if (global.questIniciada):
		$huevosdebabosa_collectable.visible = true
		$huevosdebabosa_collectable2.visible = true
		$huevosdebabosa_collectable3.visible = true
		$huevosdebabosa_collectable4.visible = true
		$huevosdebabosa_collectable5.visible = true
