extends Node2D

export (int) var width 
export (int) var height 
export (PackedScene) var Building
export (PackedScene) var verticalStreet
export (PackedScene) var horizontalStreet
export (PackedScene) var crossRoad
export (PackedScene) var corner00
export (PackedScene) var cornerh0
export (PackedScene) var corner0w
export (PackedScene) var cornerhw

var map_array = []
var tileDimension = 128
var id="build"

func _ready():
	map_array = generate_map_array()
	print_map()
	map_array[((height+1)/2)-1][((width+1)/2)-1] = 0
	for i in range(height):
		for j in range(width):
			if(map_array[i][j] == -4):  	#VERTICAL STREET
				if(i == 0 and j == 0):
					var streetTile_pos = Vector2(i*tileDimension, j*tileDimension)
					var streetTile = corner00.instance()
					streetTile.init(streetTile_pos)
					add_child(streetTile)
				elif(i == height-1 and j == 0):
					var streetTile_pos = Vector2(i*tileDimension, j*tileDimension)
					var streetTile = cornerh0.instance()
					streetTile.init(streetTile_pos)
					add_child(streetTile)
				elif(i == 0 and j == width-1):
					var streetTile_pos = Vector2(i*tileDimension, j*tileDimension)
					var streetTile = corner0w.instance()
					streetTile.init(streetTile_pos)
					add_child(streetTile)
				elif(i == height-1 and j == width-1):
					var streetTile_pos = Vector2(i*tileDimension, j*tileDimension)
					var streetTile = cornerhw.instance()
					streetTile.init(streetTile_pos)
					add_child(streetTile)
				
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
				#if Building:
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

	arr[0][0] = -4
	arr[0][width-1] = -4
	arr[height-1][width-1] = -4
	arr[height-1][0] = -4

	return arr

func print_map():
	print(map_array)
