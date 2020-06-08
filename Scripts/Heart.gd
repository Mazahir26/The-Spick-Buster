extends Area2D

func _on_Heart_area_entered(area):
	if area.is_in_group("Player") :
		area.heal(100)
		get_parent().play_sound("res://Assets/sound/jump4.ogg")
		queue_free()
	pass # Replace with function body.


func _on_Timer_timeout():
	queue_free()
	pass # Replace with function body.
