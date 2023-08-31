extends Node2D
class_name Maze

const ROOM = preload("res://Room/Room.tscn")

@export var bounds: Vector2i = Vector2i(8, 8)
@export var separation: int = 64
@export var await_time: float = 0.4

var visited_coords: Array[Vector2i]
var playhead_coord: Vector2i = Vector2i.ZERO


func _ready():
	CreateMaze()


func CreateMaze():
	var total_rooms: int = bounds.x * bounds.y
	var visited_rooms: Array[Room] # Grows and shrinks.
	var visited_grid: Array[Vector2i] # Only grows.
	
	# Create the starting room.
	var current_room: Room = ROOM.instantiate()
	add_child(current_room)
	current_room.grid.x = 0
	current_room.grid.y = 0
	current_room.position.x = 0.0
	current_room.position.y = 0.0
	
	# Need both.
	visited_rooms.append(current_room) # Size may grow and shrink.
	visited_coords.append(Vector2i(current_room.grid.x, current_room.grid.y))
	
	print("Visited Rooms: ", visited_rooms)
	print("Visited Coords: ", visited_coords)
	
	#--------------------------------------------------------------------
	# The `current_room` loop.
	#--------------------------------------------------------------------
	
	# As long as the number of rooms we visit is less than `total_rooms`.
	while visited_coords.size() < total_rooms:
		await get_tree().create_timer(await_time).timeout
		
		var grid_neighbors: Array[Vector2i]
		
		#------------------------------------------------------
		# Look for neighbors to the [north, east, south, west].
		#------------------------------------------------------
		
		# As long as our room in NOT located along the the left side?
		if current_room.grid.x - 1 >= 0:
			var coord_to_the_west: Vector2i = current_room.grid + Vector2i.LEFT
			if not visited_coords.has(coord_to_the_west):
				grid_neighbors.append(coord_to_the_west)
		
		# As long as our room is NOT located along the top side?
		if current_room.grid.y - 1 >= 0:
			var coord_to_the_north: Vector2i = current_room.grid + Vector2i.UP
			if not visited_coords.has(coord_to_the_north):
				grid_neighbors.append(coord_to_the_north)
		
		# As long as our room is NOT located along the right side?
		if current_room.grid.x + 1 < bounds.x:
			var coords_to_the_east: Vector2i = current_room.grid + Vector2i.RIGHT
			if not visited_coords.has(coords_to_the_east):
				grid_neighbors.append(coords_to_the_east)
		
		# As long as our room is NOT located on the bottom side?
		if current_room.grid.y + 1 < bounds.y:
			var coords_to_the_south: Vector2i = current_room.grid + Vector2i.DOWN
			if not visited_coords.has(coords_to_the_south):
				grid_neighbors.append(coords_to_the_south)
		
		print("Current Room ", current_room.grid, " has ", grid_neighbors.size(), " new directions to go.", grid_neighbors)
		
		#----------------------------------------------------------------
		# Pick a random neighboring room to enter and continue the logic.
		#----------------------------------------------------------------
		
		if grid_neighbors.is_empty():
			current_room = visited_rooms.pop_back()
			current_room.color = Color.ORANGE
			print("Backtracked to: ", current_room.grid)
		else:
			var rando: Vector2i = grid_neighbors.pick_random()
			
			var next_room = ROOM.instantiate()
			next_room.grid = rando
			next_room.position = rando * separation
			add_child(next_room)
			next_room.color = Color.YELLOW
			visited_rooms.append(next_room)
			visited_coords.append(Vector2i(next_room.grid))
			
			current_room.OpenPassage(next_room)
			current_room.color = Color.GREEN_YELLOW
			current_room = next_room
	
	print("Visited Coords: ", visited_coords.size())
	
	# Restore the modulated color.
	for room in get_children():
		if room is Room:
			room.modulate = Color.WHITE
	
