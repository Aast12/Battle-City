extends KinematicBody2D

var player
var id = "enemy"
var hp = 75
var speed = 300
var movement = Vector2()
var atk_rate = 1.2
var can_attack = true
var target

func _ready():
	$AttackTimer.wait_time = atk_rate

func init(target, pos):
	player = target
	position = pos

func _physics_process(delta):
	movement = (player.global_position - global_position)
	movement = movement.normalized() * speed
	rotation = (player.global_position - global_position).angle() + PI / 2
	move_and_slide(movement)
	if hp <= 0:
		queue_free()

func _process(delta):
	if can_attack and target:
		target.hp -= 10
		$AttackTimer.start()
		can_attack = false

func _on_HurtBox_body_entered(body):
	if body.id == "player":
		target = body

func _on_AttackTimer_timeout():
	can_attack = true

func _on_HurtBox_body_exited(body):
	target = null