extends Node2D

var hp
var rect = Rect2(Vector2(0,0), Vector2(0,0))
var color = Color(0.0,0.0,0.0)

func _draw():
	draw_rect(rect, color)

func _process(delta):
	print(hp)

func init(temp_hp):
	hp = temp_hp
	rect = Rect2(Vector2(50,10),Vector2(hp*10,50))
	color = Color(0.0,1.0,0.0)
	update()
