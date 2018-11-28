extends StaticBody2D

var id = "Build"
var player
var is_healing = false
var heal_factor = 50
var hospital_health = 100
var hospital_regen_rate = 50

signal building_function_available

func init(pos):
	position = pos

func _on_Area2D_body_entered(body):
	if body.id == "player":
		player = body
		is_healing = true

func _on_Area2D_body_exited(body):
	if body.id == "player":
		is_healing = false
		hospital_health += 10

func restart(_player):
	hospital_health = player.max_hp * 0.75
		
func _process(delta):
	if is_healing and (hospital_health >= player.max_hp * 0):
		hospital_health -= 100 * delta
		player.stamina = min(player.stamina + heal_factor * delta, player.max_stamina)
		if hospital_health <= player.max_hp * 0.75:
			var color = Color(1, 0, 0, 1)
			modulate = color.lightened(0.8)
