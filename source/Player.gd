extends KinematicBody2D

export (PackedScene) var Bullet
export (float) var fire_rate
export (float) var speed
var hp
var stamina
var movement
var can_shoot
var circle

func _ready():
	can_shoot = true
	$ShootTimer.wait_time = fire_rate

func get_input():
	movement = Vector2()
	var mouse_pos = get_viewport().get_mouse_position() - global_position
	if Input.is_key_pressed(KEY_W):
		movement.y -= 1
	if Input.is_key_pressed(KEY_D):
		movement.x += 1
	if Input.is_key_pressed(KEY_S):
		movement.y += 1
	if Input.is_key_pressed(KEY_A):
		movement.x -= 1
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		if can_shoot:
			shoot(get_viewport().get_mouse_position())
	
	movement = movement.normalized() * speed
	
	if movement.length() > 0:
		$Sprite.play()
	else:
		$Sprite.stop()
	
	if mouse_pos.x > -50 and mouse_pos.x < 50:
		if mouse_pos.y > 0:
			$Sprite.animation = "down"
		else:
			$Sprite.animation = "up"
	elif mouse_pos.y > -50 and mouse_pos.y < 50:
		if mouse_pos.x > 0:
			$Sprite.animation = "right"
		else:
			$Sprite.animation = "left"
	else:
		if mouse_pos.x > 0 and mouse_pos.y < 0:
			$Sprite.animation = "up right"
		elif mouse_pos.x > 0 and mouse_pos.y > 0:
			$Sprite.animation = "down right"
		elif mouse_pos.x < 0 and mouse_pos.y < 0:
			$Sprite.animation = "up left"
		else:
			$Sprite.animation = "down left"


func shoot(pos):
	var bullet = Bullet.instance()
	var direction = (pos - global_position).angle() + rand_range(-0.1, 0.1)
	bullet.start(global_position, direction)
	get_parent().add_child(bullet)
	$ShootTimer.start()
	can_shoot = false

func _physics_process(delta):
	get_input()
	movement = move_and_slide(movement)
	print(get_viewport().get_mouse_position().y)

func _on_ShootTimer_timeout():
	can_shoot = true
