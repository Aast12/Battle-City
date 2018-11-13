extends Node2D

var stamina
var rect = Rect2(Vector2(0,0), Vector2(0,0))
var color = Color(0.0,0.0,0.0)

func _draw():
	draw_rect(rect, color)

func _process(delta):
	print(stamina)

func init(temp_stamina):
	stamina = temp_stamina
	rect = Rect2(Vector2(50,10),Vector2(stamina*10,10))
	color = Color(1.0,0.0,0.0)
	update()
