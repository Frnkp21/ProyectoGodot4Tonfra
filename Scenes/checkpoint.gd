extends CharacterBody2D

var is_chatting = false

var player
var checkpointStatus = false
var scene = "res://Scenes/Forest.tscn"
var checkpointPosition = Vector2(129, 143)
var playerZoom = Vector2(3,3)

func _ready():
	pass

func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		global.lastPositon = checkpointPosition
		global.lastScene = scene
		global.lastZoom = playerZoom
