extends Area2D

var speed = 200
var dir
var Hp = 300
var stun

var Ai = preload("res://Scenes/PlayersAI.tscn")
var bullet = preload("res://Scenes/Bullet.tscn")
func _ready():
	Global.Player_Health = Hp
	Global.Player = self
func _physics_process(delta):
	if Hp <= 0 :
		_Die()
	if stun == true :
		return
	dir = get_dir()
	dir = dir.normalized()
	if global_position.x >= 1915 :
		dir.x = clamp(dir.x,-1,0)
	if global_position.x <= -1915 :
		dir.x = clamp(dir.x,0,1)
	if global_position.y <= -1415 :
		dir.y = clamp(dir.y,0,1)
	if global_position.y >= 1415 :
		dir.y = clamp(dir.y,-1,0)
	self.global_position += (dir * speed * delta)
	look_at(get_global_mouse_position())

func get_dir() :
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
var shooting = false
var firerate = 0.3

func _input(event):
	if event.is_action_pressed("shoot") :
		shooting = true
		$firerate.start()
	elif event.is_action_released("shoot") :
		shooting = false
		$firerate.wait_time = 0.001
	if event.is_action_pressed("Ai") :
		Spawn_Ai()



func _on_firerate_timeout():
	if shooting :
		var node = Global.instance_node(bullet,$MuzzelFlash.global_position,get_parent())
		node.velocity = $MuzzelFlash.global_position - global_position
		node.damage = 60
		$firerate.wait_time = firerate
		get_parent().play_sound("res://Assets/sound/hit2.ogg")
		$firerate.start()
	pass # Replace with function body.


func take_damage(value) :
	$Camera2D.shake(0.2,35,15)
	Hp -= value
	get_parent().play_sound("res://Assets/sound/hurt2.ogg")
	Global.Player_Health = Hp
	if stun == true :
		return
	dir += -dir * 12
	var temp = $CollisionShape2D.color
	$CollisionShape2D.color = Color.white
	stun  = true
	var t = Timer.new()
	t.set_wait_time(1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t,"timeout")
	$CollisionShape2D.color = temp
	stun = false



func _on_Player_area_entered(area):
	if area.is_in_group("Enemy_Bullet") :
		take_damage(25)
		area.queue_free()
	if area.is_in_group("Enemy") :
		take_damage(35)

	pass # Replace with function body.


func Spawn_Ai() :
	if Global.Can_Ai_spawn :
		get_parent().play_sound("res://Assets/sound/upgrade4.ogg")
		var pos = get_global_mouse_position()
		Global.instance_node(Ai,pos,get_parent())
		Global.Can_Ai_spawn = false

func _Die() :
	get_parent().play_sound("res://Assets/sound/lose1.ogg")
	hide()
	Global.Player_Death = true
	pass


func heal(value) :
	if Hp < 300 :
		Hp += value
		Global.Player_Health = Hp
