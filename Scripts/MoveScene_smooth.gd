extends Area2D


# Called when the node enters the scene tree for the first time.
var entered = false
@export var target_scene: String
@export var target_position: Vector2
@export var target_zoom: Vector2
# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_body_entered(body):
	if body.has_method("player"):
		entered = true


func _on_body_exited(body):
	if body.has_method("player"):
		entered = false
	
func _process(delta):
	if entered == true:
		var bodies = get_overlapping_bodies()
		for body in bodies:
			if body.name == "player":
				global.posicion = target_position
				global.zoom = target_zoom
				get_tree().change_scene_to_file("res://Scenes/" + target_scene + ".tscn")
				return
