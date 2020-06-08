tool
extends CollisionShape2D


func _draw():
	var node = Rect2(position-self.shape.extents,self.shape.extents*2)
	draw_rect(node,Color.white)



func _on_CollisionShape2D_script_changed():
	update()
	pass # Replace with function body.
