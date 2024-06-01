extends CharacterBody2D

var is_chatting = false
var player
var player_in_chat_zone = false

func _ready():
	$AnimatedSprite2D.play("Idle")
	self.visible = false
	self.process_mode = Node.PROCESS_MODE_DISABLED
	get_parent().connect("boss_defeated", Callable(self, "enable_portal"))

func portalInicio():
	pass

func interactuable():
	pass
	
func choose(array):
	array.shuffle()
	return array.front()

func _on_chatdetection_area_body_entered(body):
	if body.has_method("player"):
		player_in_chat_zone = true

func _on_chatdetection_area_body_exited(body):
	if body.has_method("player"):
		player_in_chat_zone = false

func _process(delta):
	if Input.is_action_just_pressed("chat") and player_in_chat_zone:
		print("chatting")
		$Dialogo.start()
		global.puedetp = true
		is_chatting = true

func _on_Dialogo_dialogo_finish():
	is_chatting = false
	player_in_chat_zone = false

func enable_portal():
	self.visible = true
	self.process_mode = Node.PROCESS_MODE_INHERIT
