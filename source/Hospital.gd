extends StaticBody2D

var id = "Build"
var player
var is_healing = false
var heal_factor = 1
var hospital_health = 0 

signal building_function_available

func init(pos):
	position = pos

func _on_Area2D_body_entered(body):	
	print("debug ", body.id)
	if body.id == "player":
		player = body
		is_healing = true
		print("healing")
		if Input.is_key_pressed(KEY_Z):
			is_healing = true
			

func _process(delta):
	if player and is_healing and hospital_health <= player.max_hp * 0.75:
		hospital_health += heal_factor * delta
		player.hp = min(player.hp + heal_factor * delta, player.max_hp)