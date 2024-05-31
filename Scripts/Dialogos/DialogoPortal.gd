extends Control

signal dialogo_finish

@export_file("*.json") var d_file

var dialogo = []
var current_dialogo_id = 0
var d_active = false 

func _ready():
	$NinePatchRect.visible = false
	
func start():
	if d_active:
		return
	d_active = true
	$NinePatchRect.visible = true 
	dialogo = load_dialogo()
	current_dialogo_id = -1
	next_script()
	global.chatPortalAbierto = true

func load_dialogo():
	var file = FileAccess.open("res://Dialog/portal_dialogo1.json", FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	return content

func _input(event):
	if !d_active:
		return
	if event.is_action_pressed("ui_accept"):
		next_script()

func next_script():
	current_dialogo_id += 1
	if current_dialogo_id >= len(dialogo):
		d_active = false
		$NinePatchRect.visible = false
		global.chatPortalAbierto = false
		emit_signal("dialogo_finish")
		return
		
	$NinePatchRect/name.text = dialogo[current_dialogo_id]['name']
	$NinePatchRect/text.text = dialogo[current_dialogo_id]['text']
