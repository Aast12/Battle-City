extends Node2D

export (int) var width 
export (int) var height 
export (int) var player_x
export (int) var player_y

var map_array = []

func _ready():
	var sprite = Sprite.new()
	var tile = RigidBody.new()
	add_child(sprite)
	add_child(tile)
	map_array = generate_map_array()
	print_map()

func generate_map_array():
	var arr = []
	for i in range(height):
		arr.append([])
		for j in range(width):
			arr[i].append(randi()%3)
	return arr

func print_map():
	print(map_array)
