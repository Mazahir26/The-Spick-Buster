tool
extends CollisionShape2D

export (Color) var color := Color() setget set_color
export (bool) var Border := false setget border
export (Color) var Border_color := Color() setget set_Border_color 

func _draw() -> void:
	if Border :
		draw_circle(position, shape.radius+2, Border_color)
	draw_circle(position, shape.radius, color)



func set_color(val: Color) -> void:
	color = val
	update()
func set_Border_color(val: Color) -> void:
	Border_color = val
	update()
func border(val: bool) -> void:
	Border = val
	update()
