extends Area2D

var velocity =  Vector2(0,0)
var speed = 25
var damage = 25
var look_at = null
var color = Color("3256fc") setget color_changed
func _ready():
	$CollisionShape2D.color = color
	pass
func _physics_process(delta):
	if velocity == Vector2.ZERO :
		queue_free()
	global_position += speed * velocity * delta
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass # Replace with function body.


func _on_Timer_timeout():
	queue_free()
	pass # Replace with function body.

func color_changed(value) :
	color = value
	$CollisionShape2D.color = value
