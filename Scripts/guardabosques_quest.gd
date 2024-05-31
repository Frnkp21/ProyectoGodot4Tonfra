extends Control

signal quest_menu_closed

var quest1_active = false
var quest1_completed = false
var huevodebabosa = 0


func _process(delta):
	if quest1_active:
		if huevodebabosa == 5:
			print("quest1 completed")
			quest1_active = false
			quest1_completed = true
			play_finish_quest_anim()
	

func quest1_chat():
	$quest1_ui.visible = true

func next_quest():
	if !quest1_completed:
		quest1_chat()
	else:
		$no_quest.visible = true
		await get_tree().create_timer(3).timeout
		$no_quest.visible = false

func _on_yes_button_1_pressed():
	$quest1_ui.visible = false
	quest1_active = true
	huevodebabosa = 0
	global.questIniciada = true
	emit_signal("quest_menu_closed")


func _on_no_buttton_1_pressed():
	$quest1_ui.visible = false
	quest1_active = false
	emit_signal("quest_menu_closed")
	
func huevodebabosa_collected():
	huevodebabosa += 1
	print("huevo para la quest")

func play_finish_quest_anim():
	$finished_quest.visible = true
	$completed.play()
	await get_tree().create_timer(120).timeout
	$finished_quest.visible = false
