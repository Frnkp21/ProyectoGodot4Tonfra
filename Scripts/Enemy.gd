extends CharacterBody2D
class_name Enemy

var speed = 70
var player_chase = false
var player = null

var health = 100
var player_inattack_zone = false

var can_take_damage = true

var drop_exp = 50

var colorDiferente = false
var originalModulateColor = Color(1, 1, 1, 1)
var pararIdle : bool
	
func _physics_process(delta):
	deal_with_damage()
	update_health()
	if (!pararIdle):
		if (player_chase):
			position += (player.position - position)/speed
			$AnimatedSprite2D.play("Idle")
		else:
			$AnimatedSprite2D.play("Walk")
		move_and_collide(Vector2(0,0))


func _on_detecting_area_body_entered(body):
	player = body
	player_chase = true


func _on_detecting_area_body_exited(body):
	player = null
	player_chase = false

func enemy():
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
					$AnimatedSprite2D.modulate = Color(1,0,0,1)
					time_out()
					var direction = (position - player.position).normalized()
					var push_distance = 20
					position += direction * push_distance
				can_take_damage = false
				print ("slime health ",health)
				if health <= 0:
					self.queue_free()
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


func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		print("gordito")
		$AnimatedSprite2D.play("MonsterAttack")
		pararIdle = true


func _on_area_2d_body_exited(body):
	if body.has_method("player"):
		print("adios gordito")
		pararIdle = false
