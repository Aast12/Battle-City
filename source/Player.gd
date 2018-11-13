extends KinematicBody2D

export (PackedScene) var Bullet

const id = "player"
var max_hp = 100
var max_stamina = 75
var fire_rate = 0.2
var def_speed = 400
var speed_factor = 1.5
var t_speed_factor = 0.5
var hp
var stamina
var d_stamina
var speed
var movement
var mouse_pos
var can_shoot
var is_running
var tired

func _ready():
	hp = max_hp
	stamina = max_stamina
	d_stamina = 0
	speed = def_speed
	mouse_pos = Vector2()
	can_shoot = true
	is_running = false
	tired = false
	$ShootTimer.wait_time = fire_rate

func get_input():
	movement = Vector2()
	mouse_pos = $Camera2d.get_global_mouse_position() - global_position
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
			shoot($Camera2d.get_global_mouse_position())
	if Input.is_key_pressed(KEY_SHIFT):
		if not tired:
			is_running = true
			d_stamina -= 1
	if not Input.is_key_pressed(KEY_SHIFT):
		is_running = false
	
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
	bullet.start(global_position + mouse_pos.normalized() * 35, direction)
	get_parent().add_child(bullet)
	$ShootTimer.start()
	can_shoot = false

func _physics_process(delta):
	get_input()
	stamina += d_stamina * delta * 20
	d_stamina = 0
	if is_running:
		speed = def_speed * speed_factor
	if stamina < 0:
		stamina = 0
		tired = true
	if stamina >= max_stamina:
		stamina = max_stamina
		tired = false
	if tired:
		speed = def_speed * t_speed_factor
	elif not tired and not is_running:
		speed = def_speed
	stamina += delta * 5
	movement = move_and_slide(movement)

func _process(delta):
	$Camera2d/CanvasLayer/Stamina/StaminaBar.init(stamina)
	$Camera2d/CanvasLayer/Hp/HpBar.init(hp)

func _on_ShootTimer_timeout():
	can_shoot = true
