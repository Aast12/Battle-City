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

func _process(delta):
	pass