extends KinematicBody2D

signal dead

export (PackedScene) var Bullet

const id = "player"
var currency = 0
var max_hp = 100
var max_stamina = 75
var fire_rate = 0.2
var max_fire_rate = 0.01
var def_speed = 160
var speed_factor = 1.5
var t_speed_factor = 0.5
var atk = 30
var hp
var stamina
var d_stamina
var speed
var movement
var mouse_pos
var can_shoot
var is_shooting
var is_running
var tired
var shoot_position
var add = ''
var pushable = false

func _ready():
	hp = max_hp
	stamina = max_stamina
	d_stamina = 0
	speed = def_speed
	mouse_pos = Vector2()
	can_shoot = true
	is_running = false
	tired = false
	is_shooting = false
	$ShootTimer.wait_time = fire_rate

func get_input(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().set_pause(true)
		get_parent().get_node('PauseMenu/Panel').show()
		get_parent().get_node('PauseMenu/ColorRect').show()
		#get_parent().get_node('PauseMenu').layer = 50
	
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
			is_shooting = true
			add = ' s'
	if not Input.is_mouse_button_pressed(BUTTON_LEFT):
		is_shooting = false
		add = ''
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
			$Sprite.animation = "running down" + add
			if movement.length() == 0:
				$Sprite.animation = "down"# + add
			shoot_position = $SDownPos
			$Sprite.flip_h = false
		else:
			$Sprite.animation = "running up"
			if movement.length() == 0:
				$Sprite.animation = "up" #+ add
			shoot_position = $SUpPos
			$Sprite.flip_h = false
	elif mouse_pos.y > -50 and mouse_pos.y < 50:
		if mouse_pos.x > 0:
			$Sprite.animation = "running left" + add
			if movement.length() == 0:
				$Sprite.animation = "left" #+ add
			shoot_position = $SRightPos
			$Sprite.flip_h = true
		else:
			$Sprite.animation = "running left" + add
			if movement.length() == 0:
				$Sprite.animation = "left" #+ add
			shoot_position = $SLeftPos
			$Sprite.flip_h = false
	else:
		if mouse_pos.x > 0 and mouse_pos.y < 0:
			$Sprite.animation = "running up left" + add
			if movement.length() == 0:
				$Sprite.animation = "up left" #+ add
			shoot_position = $SUpRightPos
			$Sprite.flip_h = true
		elif mouse_pos.x > 0 and mouse_pos.y > 0:
			$Sprite.animation = "running down left" + add
			if movement.length() == 0:
				$Sprite.animation = "down left"# + add
			shoot_position = $SDownRightPos
			$Sprite.flip_h = true
		elif mouse_pos.x < 0 and mouse_pos.y < 0:
			$Sprite.animation = "running up left" + add
			if movement.length() == 0:
				$Sprite.animation = "up left"# + add
			shoot_position = $SUpLeftPos
			$Sprite.flip_h = false
		else:
			$Sprite.animation = "running down left" + add
			if movement.length() == 0:
				$Sprite.animation = "down left" #+ add
			shoot_position = $SDownLeftPos
			$Sprite.flip_h = false


func shoot(pos):
	var bullet = Bullet.instance()
	var direction = (pos - global_position).angle() + rand_range(-0.1, 0.1)
	#bullet.start(global_position + mouse_pos.normalized() * 35, direction)
	bullet.start(shoot_position.global_position + mouse_pos.normalized() * 10, direction, id, atk)
	get_parent().add_child(bullet)
	$ShootTimer.start()
	can_shoot = false

func _physics_process(delta):
	get_input(delta)
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
	move_and_collide(movement * delta)
	if position.x <= -96:
		position.x = -96
	if position.x >= 10460:
		position.x = 10460
	if position.y <= -96:
		position.y = -96
	if position.y >= 10445:
		position.y = 10445

func _process(delta):
	if hp <= 0:
		emit_signal("dead")

func _on_ShootTimer_timeout():
	can_shoot = true
