extends Area2D


var speed = 80
var stun = false
var velocity = Vector2()
var hp = 125
var heart = preload("res://Scenes/Heart.tscn")
var Blood = preload("res://Scenes/Blood.tscn")
func _process(delta):
	if Global.Player and stun == false  : 
		velocity= global_position.direction_to(Global.Player.global_position)
		global_rotation_degrees += 2
	velocity = lerp(velocity,Vector2.ZERO,0.4)
	global_position += velocity * speed * delta
	if hp <= 0 :
		var node = Global.instance_node(Blood,self.global_position,get_parent())
		node.global_rotation = velocity.angle()
		node.modulate = Color("813131")
		Global.Score += 10
		get_parent().play_sound("res://Assets/sound/explosion4.ogg")
		Spawn_Heart()
		queue_free()

func _on_Enemy_area_entered(area):
	if area.is_in_group("Player_Bullet") or area.is_in_group("Bullet") :
		if area.is_in_group("Bullet") :
			Global.camera.shake(0.2,15,8)
		if stun == true :
			area.queue_free()
			return
		modulate = Color.white
		velocity += -velocity * 12
		stun = true
		$Stun.start()
		area.queue_free()
		hp -= area.damage
	if area.is_in_group("Player") :
		Global.Score += 10
		self.queue_free()
	if area.is_in_group("Player_Ai") :
		Global.Score += 10
		self.queue_free()
	pass # Replace with function body.


func _on_Stun_timeout():
	modulate = Color("fe4a4a")
	stun = false
	pass # Replace with function body.


func _on_speed_increaser_timeout():
	speed += 3
	pass # Replace with function body.

func on_Destroy() :
	var node = Global.instance_node(Blood,self.global_position,get_parent())
	node.global_rotation = velocity.angle()
	node.modulate = Color("813131")
	queue_free()

func Spawn_Heart() :
	var ttp = Global.Rand_range(10)
	if int(ttp) > 15 :
		Global.instance_node(heart,self.global_position,get_parent())
		pass
