extends CollisionShape2D

signal bloque_puerta

func _ready():
	$AnimatedSprite2D.play("Idle")
	bloque_invisible = $BloqueInvisibleParaPuerta

func interactuable():
	emit_signal("bloque_puerta")
	queue_free()
