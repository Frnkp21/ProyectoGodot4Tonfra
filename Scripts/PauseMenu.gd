extends Control
@onready var canvas_layer = %CanvasLayer

func _ready():
	pass
	
func _on_button_pressed():
	state = !state
	get_tree().paused = false
	canvas_layer.visible = false
	
func _input(event):
	if Input.is_action_just_pressed("pused"):
		state = !state 

func _process(delta):
	if Input.is_action_just_pressed("pused"):
		get_tree().paused = state
		canvas_layer.visible = state
		
func _on_button_2_pressed():
	get_tree().paused = false
	state = !state
	canvas_layer.visible = false
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
	
var state : bool = false

	



