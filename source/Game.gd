extends Node

export (PackedScene) var Enemy
export (PackedScene) var Sniper
export (PackedScene) var Round
export (PackedScene) var SurviveRound


var day_time = 300
var is_day = true
var day_transition = false
var nightColor = Color(128.0 / 255, 151.0 / 255, 188.0 / 255, 1)
var lightVal = 1

var round_level = 0
var enemies_killed = 0
var round_active = false
var kill_counter = 0



var aim = load("res://Art/aim.png")
#var beam = load("res://beam.png")

func kill_wave_init(num):
	generate_enemies(round_level * 5 + 10)
	var wave = Round.instance()
	wave.init(num, "Kill 100 enemies")
	add_child(wave)
	kill_counter = 0

func kill_wave_check():
	pass

func generate_enemies(amount):
	#var amount = 10
	print("generated")
	#melee enemies
	for i in range(amount):
		var enemy_pos = Vector2(rand_range(-1000, 1000), rand_range(-1000, 1000))
		var enemy = Enemy.instance()
		enemy.init($Player, enemy_pos)
		enemy.add_to_group("enemies")
		add_child(enemy)
		enemy.connect("eliminated", self, "k_counter_increment")
	#sniper enemies
	for i in range(amount):
		var enemy_pos = Vector2(rand_range(-1000, 1000), rand_range(-1000, 1000))
		var enemy = Sniper.instance()
		enemy.init($Player, enemy_pos)
		enemy.add_to_group("enemies")
		add_child(enemy)
		enemy.connect("eliminated", self, "k_counter_increment")

func k_counter_increment():
	kill_counter += 1

func _ready():
	get_viewport().audio_listener_enable_2d = true
	$Player/AudioStreamPlayer2D.play()
	#generate_enemies(10)
	#$Player.modulate = ColorN("azure", 1)
	#$Player.get_node("Sprite").modulate = night.lightened(0)
	Input.set_custom_mouse_cursor(aim)
	$HUD/HpBar.max_value = $Player.max_hp
	$HUD/StaBar.max_value = $Player.max_stamina
	$DayCycle.wait_time = day_time
	$DayCycle.start()
	
	#kill_wave(10)
	var level = SurviveRound.instance()
	add_child(level)
	level.connect("spawn_enemies", self, "generate_enemies")
	level.init(1)
	round_active = true
	#generate_enemies()

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
	if not is_day:
		 get_tree().call_group("enemies", "night_boost")
	else:
		get_tree().call_group("enemies", "day_revert")
