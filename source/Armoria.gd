extends StaticBody2D

var id = "Build"
var player
var increassing_fr = false
var rate_factor = 0.2
var armoria_health = 200
var armoria_regen_rate = 100

signal building_function_available

func init(pos):
	position = pos

func _on_Area2D_body_entered(body):
	print("debug ", body.id)
	if body.id == "player":
		player = body
		increassing_fr = true

func _on_Area2D_body_exited(body):
	if body.id == "player":
		increassing_fr = false
		armoria_health += 10

func restart(_player):
	armoria_health = 200
		
func _process(delta):
	if increassing_fr and (armoria_health >= 0):
		armoria_health -= 10 * delta
		player.fire_rate = min(player.fire_rate + rate_factor * delta, player.max_fire_rate)
		print(player.fire_rate)
		if armoria_health <= 0:
			modulate = Color(1, 0, 0, 1)