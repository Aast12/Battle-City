extends Node

export (PackedScene) var Enemy

#var enemies = []
#var wr = []

func _ready():
	for i in range(1):
		var enemy_pos = Vector2(randi() % int(get_viewport().size.x), randi() % int(get_viewport().size.y))
		var enemy = Enemy.instance()
		enemy.init($Player, enemy_pos)
		#wr = weakref(enemy)
		add_child(enemy)

func _process(delta):
	pass
