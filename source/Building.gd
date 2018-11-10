extends StaticBody2D

var player
var is_healing = false
var heal_factor = 1
var hospital_health = 0 

func _on_Area2D_body_entered(body):	
	if body.id == "player":
		player = body
		if Input.is_key_pressed(KEY_Z):
			is_healing = true

func _process(delta):
	if player and is_healing and hospital_health + player.max_hp * 0.75 <= player.max_hp * 0.75:
		player.hp = min(player.hp + heal_factor * delta, player.max_hp)