extends CanvasLayer

var Paused = false
var total_Score : int = 0
func _ready():
	$Pause_Menu.hide()
	$Game_Over.hide()
	$Ui/Player_Health_Bar.max_value = Global.Player_Health
	$Ui/Player_Health_Bar.value = Global.Player_Health
	

func Ui_Update() :
	$Ui/Player_Health_Bar.value = Global.Player_Health
	$Ui/Score.text = "Score : " + str(Global.Score)

func Ai_Spawned() :
	$Ui/Player_Ai/Tween.interpolate_property($Ui/Player_Ai,"value",5,100,Global.Ai_Spawn_Time,Tween.TRANS_QUAD,Tween.EASE_IN)
	$Ui/Player_Ai/Tween.start()


func _on_Tween_tween_all_completed():
	Global.Can_Ai_spawn = true
	pass # Replace with function body.

func Player_Died():
	$Ui.hide()
	$AnimationPlayer.play("Game_Over")
	$Game_Over/Score/Score_Tween.interpolate_method(self,"Total_Score",total_Score,Global.Score,3,Tween.TRANS_QUAD,Tween.EASE_IN)
	$Game_Over/Score/Score_Tween.start()
	$Game_Over/Score/Particles2D.emitting = true
	Input.set_custom_mouse_cursor(null)
	

func _on_Retry_pressed():
	Global.Score = 0
	var err =get_tree().reload_current_scene()
	if err :
		get_tree().quit()
	pass # Replace with function body.


func Total_Score(value) :
	total_Score = value 
	$Game_Over/Score.text = "SCORE : " + str(total_Score)


func _input(event):
	if event.is_action_pressed("Pause") :
		if Paused :
			Paused = false
			Input.set_custom_mouse_cursor(load("res://Assets/crosshair051.png"))
			_pause(Paused)
		else : 
			Paused = true
			Input.set_custom_mouse_cursor(null)
			_pause(Paused)

func _pause(value) :
	Paused = value
	if value :
		$AnimationPlayer.play("Pause_Show")
		$Ui.hide()
		get_tree().paused = true
	else : 
		$AnimationPlayer.play("Pause_Hide")
		$Ui.show()
		get_tree().paused = false


func _on_Resume_pressed():
	if Paused == true :
		Paused = false
		_pause(Paused)
	pass # Replace with function body.


func _on_Score_Tween_tween_all_completed():
	$Game_Over/Score/Particles2D.emitting = false
	pass # Replace with function body.



func _on_MainMenu_pressed():
	var err = get_tree().change_scene("res://Scenes/Main_Menu.tscn")
	if err !=OK :
		get_tree().quit()
	pass # Replace with function body.
