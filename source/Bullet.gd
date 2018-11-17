extends Area2D

export (int) var speed = 1000
var movement = Vector2()

func _ready():
	pass

func start(pos, direction):
	position = pos
	rotation = direction + PI / 2
	movement = Vector2(speed, 0).rotated(direction)

func _physics_process(delta):
	position += movement * delta


func _on_Bullet_body_entered(body):
	if body.id == "enemy":
		body.hp -= randi() % 30 + 10
		queue_free()
