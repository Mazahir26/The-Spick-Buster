extends Control

func _ready():
	get_tree().paused = false
	Input.set_custom_mouse_cursor(null)
	$home.show()
	$Htp.hide()


func _on_Controls_pressed():
	$AnimationPlayer.play("How to play Show")
	pass # Replace with function body.


func _on_Back_pressed():
	$AnimationPlayer.play("how to play hide")
	pass # Replace with function body.


func _on_Play_pressed():
	var err = get_tree().change_scene("res://Scenes/Arena.tscn")
	if err :
		get_tree().quit()
	pass # Replace with function body.


func _on_Exit_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_Sound_toggled(button_pressed):
	if button_pressed :
		$home/Sound.icon = load("res://Assets/musicOff.png")
		Global.music = false
	else :
		$home/Sound.icon = load("res://Assets/musicOn.png")
		Global.music = true
	pass # Replace with function body.
