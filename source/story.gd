extends RichTextLabel

var time = 0

func _ready():
	pass

func _process(delta):
	time += delta
	if rect_position.y <= -1420:
		rect_position.y = -1419
		if time > 36:
			get_tree().change_scene("res://MainMenu.tscn")
	else:
		rect_position.y -= delta/100
	

