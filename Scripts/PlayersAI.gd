extends Area2D

var nodes
var target_pos
var target
var target_path
var velocity = Vector2()
var speed = 85
var bullet = preload("res://Scenes/Bullet.tscn")
var firerate = 0.1
var shooting = false
var search = true 
var Hp = 100
var blood = preload("res://Scenes/Blood.tscn")
var Turned_Against = false
var stun = false
var Bullet_Group = "Bullet"
var Blood_color =  "3d9330"

func _ready():
	$Turn_against.set_wait_time(Global.Rand_range(10))
	$Turn_against.start()
	$ProgressBar.max_value = Hp
	$ProgressBar.value = Hp
	find_target()
	$firerate.start()
	
	pass # Replace with function body.

func _physics_process(delta):
	if Hp <= 0 :
		var node = Global.instance_node(blood,self.global_position,get_parent())
		node.modulate = Color(Blood_color)
		node.global_rotation = velocity.angle()
		get_parent().play_sound("res://Assets/sound/hurt2.ogg")
		queue_free()
	if stun == true :
		shooting = false
		return
	if !get_parent().has_node(target_path) :
		shooting = false
		search = true
	velocity= global_position.direction_to(target_pos)
	if search == false :
		velocity = Vector2.ZERO
	global_position += velocity * speed * delta
	$CollisionShape2D.look_at(target_pos)
	pass

func find_target() :
	if Turned_Against == true :
		target = Global.Player
		target_path = Global.Player.get_path()
		target_pos = Global.Player.global_position 
		return
	nodes = get_tree().get_nodes_in_group("Enemy")
	if nodes != [] :
		set_physics_process(true)
		target = Global.Nearest_Point(nodes,self.global_position)
		target_path = target.get_path()
		target_pos = target.global_position 
	else : 
		shooting = false
		set_physics_process(false)


func _on_firerate_timeout():
	if shooting :
		var node = Global.instance_node(bullet,$CollisionShape2D/MuzzelFlash.global_position,get_parent())
		node.velocity = $CollisionShape2D/MuzzelFlash.global_position - global_position
		node.remove_from_group("Bullet")
		if Turned_Against :
			node.add_to_group("Enemy_Bullet")
			node.color = Color("d42727")
		else : node.add_to_group("Player_Bullet")
		node.damage = 75
		$firerate.wait_time = firerate
		$firerate.start()
	pass # Replace with function body.



func _on_enemy_refresh_timeout():
	find_target()
	pass # Replace with function body.

var current_target = null
func _on_Range_area_entered(area):
	if area.is_in_group("Enemy") and Turned_Against == false:
		search = false
		shooting = true
		current_target = area
	if Turned_Against == true and  area.is_in_group("Player")  :
		search = false
		shooting = true
	pass # Replace with function body.






func _on_PlayersAI_area_entered(area):
	if area.is_in_group("Enemy") and Turned_Against == false :
		take_damage(50)
	if area.is_in_group(Bullet_Group) :
		take_damage(25)
		area.queue_free()
	pass # Replace with function body.


func take_damage(value) :
	if stun == true :
		Hp -= value
		$ProgressBar.show()
		$ProgressBar.value = Hp
		return 
	var temp = $CollisionShape2D.color
	$CollisionShape2D.color = Color.whitesmoke
	Hp -= value
	$ProgressBar.show()
	$ProgressBar.value = Hp
	stun  = true
	var t = Timer.new()
	t.set_wait_time(1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t,"timeout")
	$CollisionShape2D.color = temp
	stun = false


func _on_Range_area_exited(area):
	if Turned_Against == true :
		if area.name == "Player":
			search = true
			shooting = false
	pass # Replace with function body.


func _on_Turn_against_timeout():
	var tt = Global.Rand_range(50)
	if int(tt) <= 50 :
		get_parent().play_sound("res://Assets/sound/upgrade3.ogg")
		Turned_Against = true
		$CollisionShape2D.color = Color.red
		take_damage(0)
		find_target()
		self.remove_from_group("Player_Ai")
		$Range/CollisionShape2D.shape.radius = 1
		$Range/CollisionShape2D.shape.radius = 300
		Blood_color = "fe4a4a"
		$Turn_against.queue_free()
		find_target()
	$Turn_against.start()
	pass # Replace with function body.


func on_Destroy() :
	var node = Global.instance_node(blood,self.global_position,get_parent())
	node.modulate = Color(Blood_color)
	node.global_rotation = velocity.angle()
	queue_free()
