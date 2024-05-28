extends Control

@onready var inv = preload("res://Inventory/playerinv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var is_open = false

func _ready():
	inv.update.connect(update_slots)
	update_slots()
	close()
	
func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])

func _process(delta):
	if Input.is_action_just_pressed("i"):
		if is_open:
			close()
		else:
			open()
			

func close():
	visible = false
	is_open = false

func open():
	self.visible = true
	is_open = true


func _on_vida_button_down():
	global.hpProtagonista += 5;
	print(global.hpProtagonista)

func _on_vida_button_mouse_entered():
	$NinePatchRect2/Corazon/VidaStats/VidaButton/VidaBackBlack.visible = true
	$NinePatchRect2/Corazon/VidaStats/VidaButton/VidaTextInfo.visible = true

func _on_vida_button_mouse_exited():
	$NinePatchRect2/Corazon/VidaStats/VidaButton/VidaBackBlack.visible = false
	$NinePatchRect2/Corazon/VidaStats/VidaButton/VidaTextInfo.visible = false
