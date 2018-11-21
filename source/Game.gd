extends Node

export (PackedScene) var Enemy

#var enemies = []
#var wr = []

func _ready():
	for i in range(10):
		var enemy_pos = Vector2(rand_range(-400, 1000), rand_range(-300, 700))
		var enemy = Enemy.instance()
		enemy.init($Player, enemy_pos)
		#wr = weakref(enemy)
		add_child(enemy)
		#128, 151, 188
	var night = Color(128.0 / 255, 151.0 / 255, 188.0 / 255, 1)
	$Player.get_node("Sprite").modulate = night.lightened(0)

func _process(delta):
	pass
