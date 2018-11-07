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
	if Input.is_key_pressed(KEY_W):
		movement.y -= 1
	if Input.is_key_pressed(KEY_D):
		movement.x += 1
	if Input.is_key_pressed(KEY_S):
		movement.y += 1
	if Input.is_key_pressed(KEY_A):
		movement.x -= 1
	movement = movement.normalized() * speed
	
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		if can_shoot:
			shoot(get_viewport().get_mouse_position())

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

func _on_ShootTimer_timeout():
	can_shoot = true
