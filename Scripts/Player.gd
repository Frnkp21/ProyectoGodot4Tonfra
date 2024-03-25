extends CharacterBody2D

const speed = 100
var current_dir ="none"

var mother_in_range = false
var cartelBosque_in_range = false
var xavier_in_range = false
var portalInicio_in_range = false
var guardaBosques_in_range = false
var enemy_inattack_range = false
var enemy_attack_cooldown = true
var player_alive = true

var attack_ip = false 
var is_attacking = false

var interrogante = false


func _ready():
	$AnimatedSprite.play("Idle")
	$Interact/interrogante.visible = interrogante
	$xpbar.visible = false


func _physics_process(delta):
	player_movement(delta)
	enemy_attack()
	attack()
	update_health()
	update_experience_bar()
	
	if mother_in_range == true:
		if Input.is_action_just_pressed("Interact"):
			DialogueManager.show_example_dialogue_balloon(load("res://main.dialogue"))
			return
	if cartelBosque_in_range == true:
		if Input.is_action_just_pressed("Interact"):
			DialogueManager.show_example_dialogue_balloon(load("res://cartelToBosque.dialogue"))
			return
	if xavier_in_range == true:
		if Input.is_action_just_pressed("Interact"):
			DialogueManager.show_example_dialogue_balloon(load("res://XavierChat.dialogue"))
			return
	if guardaBosques_in_range == true:
		if Input.is_action_just_pressed("Interact"):
			DialogueManager.show_example_dialogue_balloon(load("res://GuardaBosquesChat.dialogue"))
			return
	if portalInicio_in_range == true:
		if Input.is_action_just_pressed("Interact"):
			DialogueManager.show_example_dialogue_balloon(load("res://PortalInicioChat.dialogue"))
			return
	
	if global.hpProtagonista <= 0:
		player_alive=false #agregar un menu de respawn o algo
		global.hpProtagonista = 0
		get_tree().change_scene_to_file("res://Scenes/dead.tscn")
		print("player has been killed")
		self.queue_free()

func player_movement(delta):
	if !is_attacking:
		if Input.is_action_pressed("move_right"):
			current_dir = "right"
			play_anim(1)
			velocity.x = speed
			velocity.y = 0
		elif Input.is_action_pressed("move_left"):
			current_dir = "left"
			play_anim(1)
			velocity.x = -speed
			velocity.y = 0
		elif Input.is_action_pressed("move_down"):
			current_dir = "down"
			play_anim(1)
			velocity.y = speed
			velocity.x = 0
		elif Input.is_action_pressed("move_up"):
			current_dir = "up"
			play_anim(1)
			velocity.y = -speed
			velocity.x = 0
		else:
			play_anim(0)
			velocity.x = 0
			velocity.y = 0
			
		move_and_slide()


func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("Walk_Right")
		elif movement == 0:
			if attack_ip == false:
				anim.play("Right_Idle")
	if dir == "left":
		anim.flip_h = false
		if movement == 1:
			anim.play("Walk_Left")
		elif movement == 0:
			if attack_ip == false:
				anim.play("Left_Idle")
	if dir == "up":
		anim.flip_h = false
		if movement == 1:
			anim.play("Walk_Up")
		elif movement == 0:
			if attack_ip == false:
				anim.play("Up_Idle")
	if dir == "down":
		anim.flip_h = false
		if movement == 1:
			anim.play("Walk_Down")
		elif movement == 0:
			if attack_ip == false:
				anim.play("Down_Idle")


func player():
	pass

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true


func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattack_range = false
		
func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown == true:
		global.hpProtagonista = global.hpProtagonista - 10
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(global.hpProtagonista)

func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true
	
	
func attack():
	var dir = current_dir
	if Input.is_action_just_pressed("attack") and !is_attacking:
		is_attacking = true
		global.player_current_attack = true
		attack_ip = true
		if dir == "right":
			$AnimatedSprite.play("Attack_Right")
			$deal_attack_timer.start()
		if dir == "left":
			$AnimatedSprite.play("Attack_Left")
			$deal_attack_timer.start()
		if dir == "down":
			$AnimatedSprite.play("Attack_Down")
			$deal_attack_timer.start()
		if dir == "up":
			$AnimatedSprite.play("Attack_Up")
			$deal_attack_timer.start()
		


func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	global.player_current_attack = false
	is_attacking = false
	attack_ip = false


func update_health():
	var healthbar = $healthbar
	healthbar.value = global.hpProtagonista
	print(global.hpProtagonista)
	
	if global.hpProtagonista >= 100:
		healthbar.visible = false
	else: 
		healthbar.visible = true
	
	
func _on_regin_timer_timeout():
	if global.hpProtagonista < 100:
		global.hpProtagonista = global.hpProtagonista + 15
		if global.hpProtagonista > 100:
			global.hpProtagonista = 100
	if global.hpProtagonista <= 0:
		global.hpProtagonista = 0


func _on_detection_area_chat_body_entered(body):
	if body.has_method("mother"):
		mother_in_range = true
	if body.has_method("cartelBosque"):
		cartelBosque_in_range = true
	if body.has_method("xavier"):
		xavier_in_range = true
	if body.has_method("guardaBosques"):
		guardaBosques_in_range = true
	if body.has_method("portalInicio"):
		portalInicio_in_range = true

func _on_detection_area_chat_body_exited(body):
	if body.has_method("mother"):
		mother_in_range = false
	if body.has_method("cartelBosque"):
		cartelBosque_in_range = false
	if body.has_method("xavier"):
		xavier_in_range = false
	if body.has_method("guardaBosques"):
		guardaBosques_in_range = false
	if body.has_method("portalInicio"):
		portalInicio_in_range = false

func _on_interact_body_entered(body):
	if body.has_method("interactuable"):
		interrogante = true
		print("se ve")
		$Interact/interrogante.visible = interrogante

func _on_interact_body_exited(body):
	if body.has_method("interactuable"):
		interrogante = false
		print("no se ve")
		$Interact/interrogante.visible = interrogante

func gain_experience(amount):
	$xpbar.visible = true
	global.expProtagonista += amount
	while global.expProtagonista >= global.experience_threshold:
		level_up()
	update_experience_bar()
	desactivar()

func level_up():
	global.lvlProtagonista += 1
	print("Jugador ha subido de nivel al nivel: ", global.lvlProtagonista)
	global.expProtagonista -= global.experience_threshold
	global.experience_threshold *= 1.3 # Ejemplo de valor; ajusta según tus necesidades en el juego.

func update_experience_bar():
	var xpbar = $xpbar
	xpbar.value = global.expProtagonista

func desactivar():
	await get_tree().create_timer(5).timeout
	$xpbar.visible = false
