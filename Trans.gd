extends CanvasLayer


func _ready():
	layer = -1
	$AnimationPlayer.play("trans")
func trans_scene():
	layer = 1
	$AnimationPlayer.play("trans")
	await ($AnimationPlayer. animation_finished)
	$AnimationPlayer.play_backwards("trans")
	await ($AnimationPlayer. animation_finished)
	layer = -1
