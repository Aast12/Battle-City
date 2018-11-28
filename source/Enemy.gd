extends KinematicBody2D

signal eliminated

var player
var id = "enemy"
var hp = 75
var speed = 150
var max_speed = 200
var def_speed = 150
var movement = Vector2()
var atk_rate = 1.2
var atk = 5
var max_atk = 10
var def_atk = 10
var can_attack = true
var target
var pushable = true;

func _ready():
	$AttackTimer.wait_time = atk_rate
	$AnimatedSprite.play()

func init(target, pos):
	player = target
	position = pos

func push_movement(vector, delta):
	var collision = move_and_collide(vector * delta)
	if collision and collision.collider.pushable:
		collision.collider.push_movement(vector, delta)

func _physics_process(delta):
	movement = (player.global_position - global_position)
	movement = movement.normalized() * speed
	rotation = (player.global_position - global_position).angle() + PI / 2 + PI
	move_and_slide(movement)
	if position.x <= -96:
		position.x = -96
	if position.x >= 10455:
		position.x = 10455
	if position.y <= -96:
		position.y = -96
	if position.y >= 10446:
		position.y = 10446
	if hp <= 0:
		destroy()

func _process(delta):
	if can_attack and target:
		target.hp -= atk
		$AttackTimer.start()
		can_attack = false

func night_boost():
	speed = max_speed
	atk = max_atk

func day_revert():
	speed = def_speed
	atk = def_atk

func _on_AttackTimer_timeout():
	can_attack = true

func _on_HurtBox_body_exited(body):
	target = null

func destroy():
	emit_signal("eliminated")
	queue_free()