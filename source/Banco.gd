extends StaticBody2D

var id = "Bank"
var player
var is_healing = false
var heal_factor = 1
var banco_health = 10 
var cash

func _on_Area2D_body_entered(body):	
	if body.id == "player":
		player = body
		if Input.is_key_pressed(KEY_Z):
			is_healing = true
			

func _process(delta):
	if player and is_healing and banco_health > 0:
		banco_health += heal_factor * delta
		player.cash = min(player.cash + heal_factor * delta, player.max_cash)