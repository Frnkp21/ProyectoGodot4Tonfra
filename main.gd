extends Node

var portal
var boss

func _ready():
	# Instanciar el portal
	portal = preload("res://Scenes/portalFinal.tscn").instance()
	add_child(portal)
	
	# Instanciar el jefe
	boss = preload("res://Scenes/Boss.tscn").instance()
	add_child(boss)
	
	# Conectar la señal de que el jefe ha sido derrotado
	boss.connect("boss_defeated", self, "_on_boss_defeated")

func _on_boss_defeated():
	portal.enable_portal()  # Habilitar el portal
