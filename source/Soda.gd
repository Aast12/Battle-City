extends StaticBody2D

var id = "SodaBuilding"
var player
var is_healing = false
var heal_factor = 1
var hospital_health = 0 
var stamina
var max_stamina

func _on_Area2D_body_entered(body):	
	if body.id == "player":
		player = body
		if Input.is_key_pressed(KEY_Z):
			is_healing = true

func _process(delta):
	if player and is_healing:
		player.stamina = min(player.stamina + heal_factor * delta, player.max_stamina)

