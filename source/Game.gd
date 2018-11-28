extends Node

export (PackedScene) var Enemy
export (PackedScene) var Sniper

var SurviveRound = load("res://SurviveRound.tscn")
var EliminateRound = load("res://EliminateRound.tscn")
 
var round_set = [SurviveRound, EliminateRound]

var day_time = 300
var is_day = true
var day_transition = false
var nightColor = Color(128.0 / 255, 151.0 / 255, 188.0 / 255, 1)
var lightVal = 1

var round_level = 1
var enemies_killed = 0
var round_active = false
var round_waiting = false
var kill_counter = 0

var check_function

var aim = load("res://Art/aim.png")

func _ready():
	get_viewport().audio_listener_enable_2d = true
	$Player/AudioStreamPlayer2D.play()
	Input.set_custom_mouse_cursor(aim)
	$HUD/HpBar.max_value = $Player.max_hp
	$HUD/StaBar.max_value = $Player.max_stamina
	$DayCycle.wait_time = day_time
	$DayCycle.start()
	$Player.connect("dead", self, "game_over")
	$Player.position = Vector2(5184,5184)
	#new_round(round_set[0])

func new_round(RoundType):
	var level = RoundType.instance()
	add_child(level)
	level.connect("spawn_enemies", self, "generate_enemies")
	level.connect("end_wave", self, "end_function")
	level.init(round_level, kill_counter)
	check_function = funcref(level, "check")
	round_active = true

func end_function():
	check_function = funcref(self, "mock_function")
	round_active = false
	round_waiting = true
	round_level += 1
	$RoundWait.start()

func mock_function(arg1, arg2 = null, arg3 = null):
	pass

func round_manager():
	if not round_active and not round_waiting:
		randomize()
		var round_index = randi() % round_set.size()
		new_round(round_set[round_index])

func _process(delta):
	$HUD/HpBar.value = $Player.hp
	$HUD/StaBar.value = $Player.stamina
	if day_transition:
		day_transition(delta)
	if check_function:
		check_function.call_func(kill_counter)
	round_manager()

func generate_enemies(amount):
	#var amount = 10
	#melee enemies
	for i in range(amount):
		var rand_x = rand_range($Player.global_position.x + 300, $Player.global_position.x + 500)
		var rand_y = rand_range($Player.global_position.y + 300, $Player.global_position.y + 500)
		var x_fact = rand_range(0,100)
		var y_fact = rand_range(0,100)
		if x_fact > 50:
			rand_x =rand_x * (-1) 
		if y_fact > 50:
			rand_y =rand_y * (-1) 
		var enemy_pos = Vector2(rand_x, rand_y)
		var enemy = Enemy.instance()
		enemy.init($Player, enemy_pos)
		enemy.add_to_group("enemies")
		add_child(enemy)
		enemy.connect("eliminated", self, "k_counter_increment")
	#sniper enemies
	for i in range(amount):
		var rand_x = rand_range($Player.global_position.x + 300, $Player.global_position.x + 500)
		var rand_y = rand_range($Player.global_position.y + 300, $Player.global_position.y + 500)
		var x_fact = rand_range(0,100)
		var y_fact = rand_range(0,100)
		if x_fact > 50:
			rand_x =rand_x * (-1) 
		if y_fact > 50:
			rand_y =rand_y * (-1) 
		var enemy_pos = Vector2(rand_x, rand_y)
		var enemy = Sniper.instance()
		enemy.init($Player, enemy_pos)
		enemy.add_to_group("enemies")
		add_child(enemy)
		enemy.connect("eliminated", self, "k_counter_increment")

func k_counter_increment():
	kill_counter += 1

func game_over():
	var game_over_scene = load("res://GameOver.tscn").instance()
	add_child(game_over_scene)

func day_transition(delta):
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


func _on_RoundWait_timeout():
	round_waiting = false
