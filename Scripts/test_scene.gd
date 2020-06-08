extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var bar
func _ready():
	bar = $PlayersAI/ProgressBar
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Label.text = "Global_Position : " + String($PlayersAI/ProgressBar.rect_global_position)
	
	pass
