extends Node2D


func _ready(): 
	Input.set_custom_mouse_cursor(load("res://Assets/crosshair051.png"))
	if Global.music :
		$Music.play()
	$info/Tween.interpolate_property($info,"modulate",Color(1,1,1,0.8),Color(1,1,1,0),20,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$info/Tween.start()
	var nodes = get_tree().get_nodes_in_group("Spawnner")
	for i in nodes :
		i.wait_time = 5.0
	


func _on_Dificulty_timeout():
	var nodes = get_tree().get_nodes_in_group("Spawnner")
	for i in nodes :
		i.wait_time -= 0.5 
	pass # Replace with function body.




func _on_Tween_tween_all_completed():
	$info.queue_free()
	pass # Replace with function body.

func play_sound(Res) :
	if Global.music :
		$Sound.stream = load(Res)
		$Sound.play()
	pass
