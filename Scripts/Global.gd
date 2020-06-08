extends Node

var camera = null
var music = true
var Player_Death = false setget Player_Died
var Player = null
var Player_Health = 300 setget _Update_Ui
var Score : int = 0 setget Score_Change
var Ai_Spawn_Time = 1
var Can_Ai_spawn = true setget _On_Ai_Spawned
func instance_node(node, location : Vector2, parent : Node2D) :
	var node_instance = node.instance()
	parent.add_child(node_instance)
	node_instance.global_position = location
	return node_instance

func Rand_range(value) :
	var temp = rand_range(value*2,(value/2))
	return temp

func Nearest_Point(values : Array , value : Vector2) :
	var nearest_point = values[0]
	var _node = values[0]
	for i in values :
		if i.global_position.distance_to(value) < nearest_point.global_position.distance_to(value) :
			nearest_point = i
	return nearest_point

func _Update_Ui(value) :
	Player_Health = value
	var nodes = get_tree().get_nodes_in_group("UI") 
	nodes[0].Ui_Update()


func _On_Ai_Spawned(value) :
	if value == false :
		Can_Ai_spawn = false
		var nodes = get_tree().get_nodes_in_group("UI") 
		nodes[0].Ai_Spawned()
	else : Can_Ai_spawn = true

func Score_Change(value) :
	Score = value
	var nodes = get_tree().get_nodes_in_group("UI") 
	nodes[0].Ui_Update()

func Player_Died(value) :
	Player_Death = value
	var nodes = get_tree().get_nodes_in_group("UI") 
	nodes[0].Player_Died()
	nodes = get_tree().get_nodes_in_group("Enemy") 
	for i in nodes :
		i.on_Destroy()
	nodes = get_tree().get_nodes_in_group("AI") 
	for i in nodes :
		i.on_Destroy()
	nodes = get_tree().get_nodes_in_group("Spawnner") 
	for i in nodes :
		i.queue_free()
	var arena = Player.get_parent()
	var cam = Camera2D.new()
	
	cam.position = Player.global_position
	cam.current = true
	cam.limit_bottom = 1500
	cam.limit_top = -1500
	cam.limit_right = 2000
	cam.limit_left = -2000
	camera = cam
	arena.add_child(cam)
	Player.queue_free()
	

