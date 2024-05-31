extends CanvasLayer

@onready var anim = $AnimationPlayer

func _ready():
	
	#esto es como el z-index pone el canvaslayer detras del juego
	layer = -1
	$AnimationPlayer.play("trans")
	
func aparecer():
	
	layer = 1
	anim.play("trans")
	await ($AnimationPlayer. animation_finished)
	
func desaparecer():
	
	anim.play_backwards("trans")
	await ($AnimationPlayer. animation_finished)
	layer = -1

