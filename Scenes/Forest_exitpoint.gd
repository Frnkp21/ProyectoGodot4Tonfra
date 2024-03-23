extends Area2D


var entered = false
# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_body_entered(body):
	if body.has_method("player"):
		entered = true


func _on_body_exited(body):
	if body.has_method("player"):
		entered = false
	
func _process(delta):
	if entered == true:
		get_tree().change_scene_to_file("res://Scenes/Street.tscn")
