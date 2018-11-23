extends Node

export (PackedScene) var Enemy
export (PackedScene) var Sniper
#var enemies = []
#var wr = []

var arrow = load("res://Art/aim.png")
#var beam = load("res://beam.png")

func _ready():
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
	var night = Color(128.0 / 255, 151.0 / 255, 188.0 / 255, 1)
	$CanvasModulate.color = night
	#$Player.get_node("Sprite").modulate = night.lightened(0)
	
	# Changes only the arrow shape of the cursor
	# This is similar to changing it in the project settings
	Input.set_custom_mouse_cursor(arrow)

	# Changes a specific shape of the cursor (here the IBeam shape)
	#Input.set_custom_mouse_cursor(beam, Input.CURSOR_IBEAM)

func _process(delta):
	pass
