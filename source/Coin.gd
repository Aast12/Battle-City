extends Area2D

var value
var opacity = 1
var triggered = false
var end_animation = false

func _ready():
	$AddLabel.hide()
	value = int(rand_range(10, 100))

func init(pos):
	position = pos

func trigger_label():
	$AddLabel.show()
	triggered = true

func _process(delta):
	if triggered:
		$AddLabel.rect_position.y -= delta * 0.7
		$AddLabel.modulate = Color(1, 1, 1, opacity)
		opacity -= delta * 0.7
	if opacity <= 0:
		queue_free()

func _on_Coin_body_entered(body):
	if body.id == "player":
		body.currency += value
		$AddLabel.text = "+ " + str(value)
		trigger_label()
		$AnimatedSprite.hide()
