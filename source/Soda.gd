extends StaticBody2D

var id = "Build"
var player
var is_recovering = false
var recover_factor = 50
var soda_amount = 100
var hospital_regen_rate = 50

signal building_function_available

func init(pos):
	position = pos

func _on_Area2D_body_entered(body):
	if body.id == "player":
		player = body
		is_recovering = true

func _on_Area2D_body_exited(body):
	if body.id == "player":
		is_recovering = false

func restart():
	if player:
		soda_amount = player.max_stamina * 0.75
		modulate = Color(1, 0, 0, 1).lightened(1)
		
func _process(delta):
	if is_recovering and (soda_amount >= 0) and player.stamina < player.max_stamina:
		soda_amount -= recover_factor * delta
		player.stamina = min(player.stamina + recover_factor * delta, player.max_stamina)
		if soda_amount <= 0:
			var color = Color(1, 0, 0, 1)
			modulate = color.lightened(0.8)