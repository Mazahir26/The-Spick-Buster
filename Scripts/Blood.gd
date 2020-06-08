extends Node2D



func _on_frezze_timeout():
	$CPUParticles2D.set_process(false)
	$CPUParticles2D.set_physics_process(false)
	$CPUParticles2D.set_process_input(false)
	$CPUParticles2D.set_process_internal(false)
	$CPUParticles2D.set_process_unhandled_input(false)
	$CPUParticles2D.set_process_unhandled_key_input(false)
	pass # Replace with function body.


func _on_fade_timeout():
	var tween = Tween.new()
	add_child(tween)
	tween.interpolate_property(self,"modulate",self.modulate,self.modulate - Color(0,0,0,1),5.0,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	tween.connect("tween_all_completed",self,"Free")
	tween.start()
	pass # Replace with function body.
func Free():
	queue_free()
	pass
