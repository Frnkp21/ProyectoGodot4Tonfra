extends CharacterBody2D

var is_chatting = false

var player
var player_in_chat_zone = false

func _ready():
	$AnimatedSprite2D.play("Idle")

func mother():
	pass

func interactuable():
	pass

func choose(array):
	array.shuffle()
	return array.front()
	

func _on_chat_detection_area_body_entered(body):
	if body.has_method("player"):
		player_in_chat_zone = true

func _on_chat_detection_area_body_exited(body):
	if body.has_method("player"):
		player_in_chat_zone = false

func _process(delta):
	if Input.is_action_just_pressed("chat") and player_in_chat_zone:
		print("chatting")
		$DialogoMadre.start()
		global.puedetp = true
		is_chatting = true

func _on_Dialogo_dialogo_finish():
	is_chatting = false
	player_in_chat_zone = false
