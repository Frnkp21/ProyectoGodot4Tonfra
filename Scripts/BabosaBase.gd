extends Node2D

var state = "lagrima"
var player_in_area = false

var lagrimadebabosa = preload("res://Scenes/labrimadebabosa_collectable.tscn") 

@export var item: InvItem
var player  = null

func _ready():
	pass
	
func _process(delta):
	if state == "lagrima":
		$AnimatedSprite2D.play("lagrima")
		if player_in_area:
			if Input.is_action_just_pressed("Interact"):
				state = "no lagrima"


func _on_pickable_area_body_entered(body):
	if body.has_method("player"):
		player_in_area = true
		print("hola")
		player = body


func _on_pickable_area_body_exited(body):
	if body.has_method("player"):
		player_in_area = false


func drop_lagrimadebabosa():
	var lagrimadebabosa_instance = lagrimadebabosa.instantiate()
	lagrimadebabosa_instance.global_position = $Marker2D.global_position
	get_parent().add_child(lagrimadebabosa_instance)
	player.collect(item)
	
	await get_tree().create_timer(3).timeout
