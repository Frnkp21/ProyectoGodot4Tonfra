extends CharacterBody2D
class_name Boss

var speed = 70
var player_chase = false
var player = null

var health = 500
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

signal boss_defeated  # Señal para cuando el jefe sea derrotado

func _ready():
	$Cooldown_Timer.connect("timeout", Callable(self, "_on_cooldown_timer_timeout"))

func _physics_process(delta):
	tiempo_transcurrido += delta
	if (tiempo_transcurrido >= tiempo_espera):
		cronometro = true
	else:
		cronometro = false
	deal_with_damage()
	update_health()
	if (!pararIdle):
		if player_chase:
			var direction = (player.position - position).normalized()
			position += direction * speed * delta
			if direction.x > 0:
				$AnimatedSprite2D.play("WalkRight")
				last_direction = direction  # Actualiza la última dirección
			elif direction.x < 0:
				$AnimatedSprite2D.play("WalkLeft")
				last_direction = direction  # Actualiza la última dirección
		else:
			$AnimatedSprite2D.play("Idle")

	move_and_collide(Vector2(0, 0))

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
	if (random_number != null):
		if player_inattack_zone and global.player_current_attack == true:
			if can_take_damage == true:
				if (random_number >= global.criticoPersonaje):
					health = health - global.ataqueProtagonista
					colorDiferente = true
					$take_damage_cooldown.start()
				else:
					health = health - global.ataqueProtagonista * 2
					colorDiferente = true
					$take_damage_cooldown.start()
				if colorDiferente == true:
					$AnimatedSprite2D.modulate = Color(1, 0, 0, 1)
					time_out()
					var direction = (position - player.position).normalized()
					var push_distance = 20
					position += direction * push_distance
				can_take_damage = false
				print("boss health ", health)
				if health <= 0:
					self.queue_free()
					var portal = get_parent().get_node("Portal")  # Obtener el nodo del portal
					emit_signal("boss_defeated")
					portal.visible = true
					portal.process_mode = Node.PROCESS_MODE_INHERIT
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
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true

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
		print("rocaaaaaaaaas")
		$AnimatedSprite2D.play("rocks")
		can_play_superattack = false
		$Cooldown_Timer.start(5)

func _on_cooldown_timer_timeout():
	can_play_superattack = true
