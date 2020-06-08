extends Node2D


var enemy = preload("res://Scenes/Enemy.tscn")

export var wait_time = 2.0
func _ready():
	$Timer.wait_time = wait_time
	$Timer.start()


func _on_Timer_timeout():
	var tep = Vector2(Global.Rand_range(randi()%100+50),Global.Rand_range(randi()%100+50))
	Global.instance_node(enemy,self.global_position+tep,get_parent())
	$Timer.start()
	
	pass # Replace with function body.
