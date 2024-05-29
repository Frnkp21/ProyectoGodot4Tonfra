extends Control

@onready var inv = preload("res://Inventory/playerinv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var btnTrue = global.botonesActivados

var is_open = false
var hideButtons = false

func _ready():
	inv.update.connect(update_slots)
	update_slots()
	close()
	
func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])

func _process(delta):
	if global.botonesActivados:
		$NinePatchRect2/Corazon/VidaStat/VidaButton.visible = true
		$NinePatchRect2/Corazon2/DefensaStat/DefensaButton.visible = true
		$NinePatchRect2/Corazon3/AtaqueStat/AtaqueButton.visible = true
		$NinePatchRect2/Corazon4/EvasionStat/EvasionButton.visible = true
		$NinePatchRect2/Corazon8/RegenStat/RegenButton.visible = true
		$NinePatchRect2/Corazon7/CriticoStat/CriticoButton.visible = true
		$NinePatchRect2/Corazon6/AprendizajeStat/AprendizajeButton.visible = true
		$NinePatchRect2/Corazon5/SuerteStat/SuerteButton.visible = true
		if (hideButtons):
			$NinePatchRect2/Corazon/VidaStat/VidaButton.visible = false
			$NinePatchRect2/Corazon2/DefensaStat/DefensaButton.visible = false
			$NinePatchRect2/Corazon3/AtaqueStat/AtaqueButton.visible = false
			$NinePatchRect2/Corazon4/EvasionStat/EvasionButton.visible = false
			$NinePatchRect2/Corazon8/RegenStat/RegenButton.visible = false
			$NinePatchRect2/Corazon7/CriticoStat/CriticoButton.visible = false
			$NinePatchRect2/Corazon6/AprendizajeStat/AprendizajeButton.visible = false
			$NinePatchRect2/Corazon5/SuerteStat/SuerteButton.visible = false
			hideButtons = false
			global.botonesActivados = false
				
	else:
		$NinePatchRect2/Corazon/VidaStat/VidaButton.visible = false
		$NinePatchRect2/Corazon2/DefensaStat/DefensaButton.visible = false
		$NinePatchRect2/Corazon3/AtaqueStat/AtaqueButton.visible = false
		$NinePatchRect2/Corazon4/EvasionStat/EvasionButton.visible = false
		$NinePatchRect2/Corazon8/RegenStat/RegenButton.visible = false
		$NinePatchRect2/Corazon7/CriticoStat/CriticoButton.visible = false
		$NinePatchRect2/Corazon6/AprendizajeStat/AprendizajeButton.visible = false
		$NinePatchRect2/Corazon5/SuerteStat/SuerteButton.visible = false
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
	$NinePatchRect2/Corazon/VidaStat/VidaButton/VidaBackBlack.visible = true
	$NinePatchRect2/Corazon/VidaStat/VidaButton/VidaTextInfo.visible = true

func _on_vida_button_mouse_exited():
	$NinePatchRect2/Corazon/VidaStat/VidaButton/VidaBackBlack.visible = false
	$NinePatchRect2/Corazon/VidaStat/VidaButton/VidaTextInfo.visible = false

func _on_defensa_button_mouse_entered():
	$NinePatchRect2/Corazon2/DefensaStat/DefensaButton/DefensaBackBlack.visible = true
	$NinePatchRect2/Corazon2/DefensaStat/DefensaButton/DefensaTextInfo.visible = true

func _on_defensa_button_mouse_exited():
	$NinePatchRect2/Corazon2/DefensaStat/DefensaButton/DefensaBackBlack.visible = false
	$NinePatchRect2/Corazon2/DefensaStat/DefensaButton/DefensaTextInfo.visible = false

func _on_ataque_button_mouse_entered():
	$NinePatchRect2/Corazon3/AtaqueStat/AtaqueButton/AtaqueBackBlack.visible = true
	$NinePatchRect2/Corazon3/AtaqueStat/AtaqueButton/AtaqueTextInfo.visible = true

func _on_ataque_button_mouse_exited():
	$NinePatchRect2/Corazon3/AtaqueStat/AtaqueButton/AtaqueBackBlack.visible = false
	$NinePatchRect2/Corazon3/AtaqueStat/AtaqueButton/AtaqueTextInfo.visible = false

func _on_evasion_button_mouse_entered():
	$NinePatchRect2/Corazon4/EvasionStat/EvasionButton/EvasionBackBlack.visible = true
	$NinePatchRect2/Corazon4/EvasionStat/EvasionButton/EvasionTextInfo.visible = true

func _on_evasion_button_mouse_exited():
	$NinePatchRect2/Corazon4/EvasionStat/EvasionButton/EvasionBackBlack.visible = false
	$NinePatchRect2/Corazon4/EvasionStat/EvasionButton/EvasionTextInfo.visible = false

func _on_regen_button_mouse_entered():
	$NinePatchRect2/Corazon8/RegenStat/RegenButton/RegenBackBlack.visible = true
	$NinePatchRect2/Corazon8/RegenStat/RegenButton/RegenTextInfo.visible = true

func _on_regen_button_mouse_exited():
	$NinePatchRect2/Corazon8/RegenStat/RegenButton/RegenBackBlack.visible = false
	$NinePatchRect2/Corazon8/RegenStat/RegenButton/RegenTextInfo.visible = false

func _on_critico_button_mouse_entered():
	$NinePatchRect2/Corazon7/CriticoStat/CriticoButton/CriticoBackBlack.visible = true
	$NinePatchRect2/Corazon7/CriticoStat/CriticoButton/CriticoTextInfo.visible = true

func _on_critico_button_mouse_exited():
	$NinePatchRect2/Corazon7/CriticoStat/CriticoButton/CriticoBackBlack.visible = false
	$NinePatchRect2/Corazon7/CriticoStat/CriticoButton/CriticoTextInfo.visible = false

func _on_aprendizaje_button_mouse_entered():
	$NinePatchRect2/Corazon6/AprendizajeStat/AprendizajeButton/AprendizajeBackBlack.visible = true
	$NinePatchRect2/Corazon6/AprendizajeStat/AprendizajeButton/AprendizajeTextInfo.visible = true

func _on_aprendizaje_button_mouse_exited():
	$NinePatchRect2/Corazon6/AprendizajeStat/AprendizajeButton/AprendizajeBackBlack.visible = false
	$NinePatchRect2/Corazon6/AprendizajeStat/AprendizajeButton/AprendizajeTextInfo.visible = false

func _on_suerte_button_mouse_entered():
	$NinePatchRect2/Corazon5/SuerteStat/SuerteButton/SuerteBackBlack.visible = true
	$NinePatchRect2/Corazon5/SuerteStat/SuerteButton/SuerteTextInfo.visible = true

func _on_suerte_button_mouse_exited():
	$NinePatchRect2/Corazon5/SuerteStat/SuerteButton/SuerteBackBlack.visible = false
	$NinePatchRect2/Corazon5/SuerteStat/SuerteButton/SuerteTextInfo.visible = false

func mostrar_botones(btnTrue):
	if (btnTrue == true):
		$NinePatchRect2/Corazon/VidaStat/VidaButton.visible = true
		

func _on_vida_button_pressed():
	var vida = global.maxvida
	vida  += 30
	$NinePatchRect2/Corazon/VidaStat.text = str(vida)
	global.maxvida = vida
	hideButtons = true
	

func _on_defensa_button_pressed():
	var defensa = global.defensa
	defensa += 2
	global.dañoEnemigo = - 2
	$NinePatchRect2/Corazon2/DefensaStat.text = str(defensa)
	global.defensa = defensa
	hideButtons = true

func _on_ataque_button_pressed():
	var ataque = global.ataqueProtagonista
	ataque += 10
	$NinePatchRect2/Corazon3/AtaqueStat.text = str(ataque)
	global.ataqueProtagonista = ataque
	hideButtons = true

func _on_evasion_button_pressed():
	var evasion = global.evasionProtagonista
	evasion += 5
	$NinePatchRect2/Corazon4/EvasionStat.text = str(evasion)
	global.evasionProtagonista = evasion
	hideButtons = true

func _on_suerte_button_pressed():
	var suerte = global.suerteProtagonista
	suerte += 2.5
	$NinePatchRect2/Corazon5/SuerteStat.text = str(suerte)
	global.suerteProtagonista = suerte
	hideButtons = true

func _on_aprendizaje_button_pressed():
	var aprendizaje = global.aprendeizajePersonaje
	aprendizaje += 5
	$NinePatchRect2/Corazon6/AprendizajeStat.text = str(aprendizaje)
	global.aprendeizajePersonaje = aprendizaje
	hideButtons = true

func _on_critico_button_pressed():
	var critico = global.criticoPersonaje
	critico += 5
	$NinePatchRect2/Corazon7/CriticoStat.text = str(critico)
	global.criticoPersonaje = critico
	hideButtons = true


func _on_regen_button_pressed():
	var regen = global.regeneracionPersonaje
	regen += 15
	$NinePatchRect2/Corazon8/RegenStat.text = str(regen)
	global.regeneracionPersonaje = regen
	hideButtons = true
