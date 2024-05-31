extends CharacterBody2D
class_name BossSuperAttack

var speed = 70
var player_chase = false
var player = null

var health = 400
var player_inattack_zone = false

var can_take_damage = true

var drop_exp = 100

var colorDiferente = false
var originalModulateColor = Color(1, 1, 1, 1)

var pararIdle : bool

var superAttackPre = true

var last_direction = Vector2(1, 0)  # Variable para almacenar la última dirección del movimiento

var tiempo_transcurrido = 0.0
var tiempo_espera = 5.0
var cronometro = false

var can_play_superattack = true  # Variable para controlar el super ataque
var animation_duration = 3.0  # Duración de la animación de superataque

func _ready():
	$Cooldown_Timer.connect("timeout", Callable(self, "_on_cooldown_timer_timeout"))
	$AnimatedSprite2D.connect("animation_finished", Callable(self, "_on_animation_finished"))
	self.visible = false  # Hacer invisible toda la escena por defecto

func _physics_process(delta):
	tiempo_transcurrido += delta
	if tiempo_transcurrido >= tiempo_espera:
		cronometro = true
	else:
		cronometro = false
	deal_with_damage()
	update_health()
	if !pararIdle:
		if player_chase:
			var direction = (player.position - position).normalized()
			position += direction * speed * delta
			last_direction = direction  # Actualiza la última dirección
		move_and_collide(Vector2.ZERO)

func _on_detecting_area_body_entered(body):
	player = body
	player_chase = true

func _on_detecting_area_body_exited(body):
	player = null
	player_chase = false

func boss():
	pass

func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player"):
		player_inattack_zone = true

func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone = false

func deal_with_damage():
	var random_number = randi() % 100
	if random_number != null:
		if player_inattack_zone and global.player_current_attack:
			if can_take_damage:
				if random_number >= global.criticoPersonaje:
					health -= global.ataqueProtagonista
					colorDiferente = true
					$take_damage_cooldown.start()
				else:
					health -= global.ataqueProtagonista * 2
					colorDiferente = true
					$take_damage_cooldown.start()
				if colorDiferente:
					$AnimatedSprite2D.modulate = Color(1, 0, 0, 1)
					time_out()
					var direction = (position - player.position).normalized()
					var push_distance = 20
					position += direction * push_distance
				can_take_damage = false
				print("boss health ", health)
				if health <= 0:
					queue_free()
					give_experience(player)

func time_out():
	await get_tree().create_timer(0.5).timeout
	colorDiferente = false
	$AnimatedSprite2D.modulate = originalModulateColor
	print("cambia a false")

func _on_take_damage_cooldown_timeout():
	can_take_damage = true

func update_health():
	var healthbar = $healthbar
	healthbar.value = health
	healthbar.visible = health < 100

func give_experience(player):
	var exp = global.aprendeizajePersonaje + drop_exp
	player.gain_experience(exp)

func _on_attack_area_body_entered(body):
	if body.has_method("player"):
		if last_direction.x > 0:
			$AnimatedSprite2D.play("AttackRight")
		else:
			$AnimatedSprite2D.play("AttackLeft")
		pararIdle = true

func _on_attack_area_body_exited(body):
	if body.has_method("player"):
		pararIdle = false

func _on_super_attack_area_body_entered(body):
	if body.has_method("player") and can_play_superattack:
		activate_super_attack()

func _on_cooldown_timer_timeout():
	can_play_superattack = true
	if player and player_inattack_zone:
		activate_super_attack()

func _on_animation_finished():
	if $AnimatedSprite2D.animation == "rocks":
		self.visible = false

func activate_super_attack():
	print("rocaaaaaaaaas")
	self.visible = true
	$AnimatedSprite2D.play("rocks")
	can_play_superattack = false
	$Cooldown_Timer.start(15)
	get_tree().create_timer(animation_duration).connect("timeout", Callable(self, "_on_super_attack_animation_timeout"))

func _on_super_attack_animation_timeout():
	self.visible = false
