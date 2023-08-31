extends Node2D
class_name Maze

const ROOM = preload("res://Room/Room.tscn")

@export var bounds: Vector2i = Vector2i(8, 8)
@export var separation: int = 64

var maze_offset: Vector2i = Vector2i(128, 128) # Test var.

var visited_coords: Array[Vector2i]
var playhead_coord: Vector2i = Vector2i.ZERO


func _ready():
	CreateMaze()


func CreateMaze():
	var total_rooms: int = bounds.x * bounds.y
	
	# Run a loop until the playhead has visited every cell.
	while visited_coords.size() < total_rooms:
		await get_tree().create_timer(0.3).timeout
		
		# Random.
		
		# If we already have our first room.
		if visited_coords.size() > 0:
			
			# Add new room.
			var room = ROOM.instantiate()
			add_child(room)
			room.position = playhead_coord * separation + maze_offset
			
			
			
			room.OpenPassage(random_direction)
			
			# Update the playhead.
			playhead_coord += Vector2i.RIGHT
			
			# Find grid position.
			print("PLAYHEAD: ", playhead_coord)
			
			
			
			# Probably the first time running.
		else:
			visited_coords.append(playhead_coord)
			
			
			
			
			
			
			
			# Knock down a wall.
			# Look at where we've been.
			var random_direction = Room.Passage.EAST
			
			# Where can we go?
			var grid_check: Vector2i
			
			match random_direction:
				Room.Passage.NORTH:
					grid_check = playhead_coord + Vector2i.UP
				Room.Passage.EAST:
					grid_check = playhead_coord + Vector2i.RIGHT
				Room.Passage.SOUTH:
					grid_check = playhead_coord + Vector2i.DOWN
				Room.Passage.WEST:
					grid_check = playhead_coord + Vector2i.LEFT
			
			print("GridCheck: ", grid_check)
			if visited_coords.has(grid_check):
				print(grid_check)
			
			
			# Add new room.
			# Start in one spot.
			var room = ROOM.instantiate()
			add_child(room)
			
#			room.grid_position = playhead_coord
			room.position = playhead_coord * separation + maze_offset
			
			# Random.
			room.OpenPassage(random_direction)
			
			# Update the playhead.
			playhead_coord += Vector2i.RIGHT
			
			# Find grid position.
			print("PLAYHEAD: ", playhead_coord)
			
			
		# Close all the doors around the edges of the maze.
#		if room.grid_position.x <= 0:
#			room.HideDoor(Room.Door.WEST)
#		if room.grid_position.x > bounds.x - 2:
#			room.HideDoor(Room.Door.EAST)
#		if room.grid_position.y <= 0:
#			room.HideDoor(Room.Door.NORTH)
#		if room.grid_position.y > bounds.y - 2:
#			room.HideDoor(Room.Door.SOUTH)
	
	
