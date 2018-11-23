extends Node2D

export (int) var width 
export (int) var height 
export (PackedScene) var Building
export (PackedScene) var verticalStreet
export (PackedScene) var horizontalStreet
export (PackedScene) var crossRoad

var map_array = []
var tileDimension = 128
var id="build"

func _ready():
	map_array = generate_map_array()
	print_map()
	map_array[((height+1)/2)-1][((width+1)/2)-1] = 0
	for i in range(height):
		for j in range(width):
			if(map_array[i][j] == -2 and map_array[i][j]):  	#VERTICAL STREET
				var streetTile_pos = Vector2(i*tileDimension, j*tileDimension)
				var streetTile = verticalStreet.instance()
				streetTile.init(streetTile_pos)
				add_child(streetTile)

			elif(map_array[i][j] == -1 and map_array[i][j]):	#HORIZONTAL STREET
				var streetTile_pos = Vector2(i*tileDimension, j*tileDimension)
				var streetTile = horizontalStreet.instance()
				streetTile.init(streetTile_pos)
				add_child(streetTile)

			elif(map_array[i][j] == -3 and map_array[i][j]):	#CROSS ROAD
				var streetTile_pos = Vector2(i*tileDimension, j*tileDimension)
				var streetTile = crossRoad.instance()
				streetTile.init(streetTile_pos)
				add_child(streetTile)

			elif(map_array[i][j] == 1):							#BUILDING
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

	for p in range(height):
		for q in range(width):
			if(p%2 == 0):
				arr[p][q] = -2
			elif(q%2 == 0):
				arr[p][q] = -1

	for n in range(height):
		for m in range(width):
			if((n+1)%2 != 0 and (m+1)%2 != 0):
				arr[n][m] = -3

	return arr

func print_map():
	print(map_array)
