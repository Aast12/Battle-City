extends StaticBody2D

var id = "Build"
var player

func init(pos):
	position = pos

func _on_Area2D_body_entered(body):
	if body.id == "player":
		player = body

func _on_Area2D_body_exited(body):
	if body.id == "player":
		pass

func restart(_player):
	pass
		
func _process(delta):
	pass