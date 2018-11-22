extends Node2D

export (int) var width 
export (int) var height 
export (PackedScene) var Building

var map_array = []
var tileDimension = 128

func _ready():
	map_array = generate_map_array()
	print_map()
	for i in range(height):
		for j in range(width):
			if(map_array[i][j] == 1):
				var building_pos = Vector2(i*tileDimension, j*tileDimension)
				var genericBuilding = Building.instance()
				genericBuilding.init(building_pos)
				add_child(genericBuilding)

func generate_map_array():
	var arr = []
	for i in range(height):
		arr.append([])
		for j in range(width):
			randomize()
			arr[i].append(randi()%3)
	return arr

func print_map():
	print(map_array)
