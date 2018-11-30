extends Area2D

export (int) var speed = 400
var movement = Vector2()
var owner_id
var damage

func _ready():
	get_viewport().audio_listener_enable_2d = true
	$AudioStreamPlayer2D.play()

func start(pos, direction, id, dmg):
	damage = dmg
	owner_id = id
	position = pos
	rotation = direction + PI / 2
	movement = Vector2(speed, 0).rotated(direction)

func _physics_process(delta):
	position += movement * delta

func _on_Bullet_body_entered(body):
	if body.id != owner_id and body.id != "Build":
		body.hp -= rand_range(5, damage)
		if body.hp <= 0:
			pass
	if body.id != owner_id:
		queue_free()
