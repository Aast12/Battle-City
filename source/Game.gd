extends Node

export (PackedScene) var Enemy
export (PackedScene) var Sniper

var day_time = 5
var is_day = true
var day_transition = false
var nightColor = Color(128.0 / 255, 151.0 / 255, 188.0 / 255, 1)
var lightVal = 1
#var enemies = []
#var wr = []

var aim = load("res://Art/aim.png")
#var beam = load("res://beam.png")

func _ready():
	get_viewport().audio_listener_enable_2d = true
	$Player/AudioStreamPlayer2D.play()
	for i in range(10):
		var enemy_pos = Vector2(rand_range(-1000, 1000), rand_range(-1000, 1000))
		var enemy = Enemy.instance()
		enemy.init($Player, enemy_pos)
		#wr = weakref(enemy)
		add_child(enemy)
		#128, 151, 188
	for i in range(10):
		var enemy_pos = Vector2(rand_range(-1000, 1000), rand_range(-1000, 1000))
		var enemy = Sniper.instance()
		enemy.init($Player, enemy_pos)
		#wr = weakref(enemy)
		add_child(enemy)
		#128, 151, 188
	$Player.modulate = ColorN("azure", 1)
	#$Player.get_node("Sprite").modulate = night.lightened(0)
	Input.set_custom_mouse_cursor(aim)
	$HUD/HpBar.max_value = $Player.max_hp
	$HUD/StaBar.max_value = $Player.max_stamina
	$DayCycle.wait_time = day_time
	$DayCycle.start()

func _process(delta):
	$HUD/HpBar.value = $Player.hp
	$HUD/StaBar.value = $Player.stamina
	if day_transition:
		$CanvasModulate.color = nightColor.lightened(lightVal)
		if is_day:
			lightVal += delta
			if lightVal >= 1:
				day_transition = false
				$DayCycle.start()
		else:
			lightVal -= delta
			if lightVal <= 0:
				day_transition = false
				$DayCycle.start()

func _on_DayCycle_timeout():
	day_transition = true
	is_day = not is_day
