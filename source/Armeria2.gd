extends StaticBody2D

var id = "Armeria 2"
var player
var is_healing = false
var heal_factor = 1
var hospital_health = 0 
var rate_factor = 2

func _on_Area2D_body_entered(body):	
	if body.id == "player":
		player = body
		if Input.is_key_pressed(KEY_Z):
			is_healing = true
			

func _process(delta):
	if player and is_healing:
		$Timer.start()
		player.def_speed = player.def_speed * rate_factor
		

func _on_Timer_timeout():
	player.def_speed = player.def_speed/rate_factor
	
func _ready():
	$Timer.wait_time = 5
