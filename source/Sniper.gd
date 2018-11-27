extends KinematicBody2D

signal eliminated

var player
var id = "enemy"
var hp = 75
var speed = 150
var max_speed = 200
var def_speed = 150
var movement = Vector2()
var atk_rate = 2
var atk = 5
var max_atk = 10
var def_atk = 10
var can_attack = true
var target_found = false
var target
var pushable = true

export (PackedScene) var Bullet

func _ready():
	$AttackTimer.wait_time = atk_rate
	$AnimatedSprite.play()
	modulate = Color(0, 1, 0, 1)

func init(target, pos):
	player = target
	position = pos

func move():
	movement = (player.global_position - global_position)
	movement = movement.normalized() * speed
	rotation = (player.global_position - global_position).angle() + PI / 2 + PI
	move_and_slide(movement)

func push_movement(vector, delta):
	var collision = move_and_collide(vector * delta)
	if collision and collision.collider.pushable:
		collision.collider.push_movement(vector, delta)

func shoot(pos):
	var bullet = Bullet.instance()
	var direction = (pos - global_position).angle() + rand_range(-0.1, 0.1)
	bullet.start(global_position + (pos - global_position).normalized() * 16, direction, id, atk)
	get_parent().add_child(bullet)
	$AttackTimer.start()
	can_attack = false

func night_boost():
	speed = max_speed
	atk = max_atk

func day_revert():
	speed = def_speed
	atk = def_atk


func _physics_process(delta):
	if not target_found:
		move()
	if hp <= 0:
		emit_signal("eliminated")
		queue_free()

func _process(delta):
	if can_attack and target:
		shoot(target.position)

func _on_AttackTimer_timeout():
	can_attack = true

func _on_ShootRange_body_entered(body):
	if body.id == "player":
		target = body
		target_found = true

func _on_ShootRange_body_exited(body):
	if body.id == "player":
		target = null
		target_found = false
