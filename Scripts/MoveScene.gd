extends Area2D

@export var target_scene: String
@export var target_position: Vector2
@export var target_zoom: Vector2

func _input(event):
	# Verificar si el evento es de tipo KEY y si la tecla es la que deseas
	if event is InputEventKey and event.pressed and event.keycode == KEY_E:
		call("cambiar_escena")

func cambiar_escena():
	# Cambiar la escena solo si el cuerpodel jugador está en el área
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "player":
			# Guarda las coordenadas en la clase de coordenadas
			Coordenadas.posicion = target_position
			Coordenadas.zoom = target_zoom
			# Abre la nueva escena
			get_tree().change_scene_to_file("res://Scenes/" + target_scene + ".tscn")
			return  # Evitar cambiar la escena múltiples veces si hay varios cuerpos solapados
