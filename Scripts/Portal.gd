extends CharacterBody2D


var is_roaming = true
var is_chatting = false

var player
var player_in_chat_zone = false

func _ready():
	$AnimatedSprite2D.play("Idle")

func portalInicio():
	pass

func interactuable():
	pass
func choose(array):
	array.shuffle()
	return array.front()
	


func _on_chatdetection_area_body_entered(body):
	if body.has_method("player"):
		player = body
		player_in_chat_zone = true


func _on_chatdetection_area_body_exited(body):
	if body.has_method("player"):
		player_in_chat_zone = false

func _process(delta):
	if Input.is_action_just_pressed("chat"):
		print("chatting")
		is_chatting = true

func _on_control_dialogo_finish():
	is_chatting = false
	is_roaming = true
 
