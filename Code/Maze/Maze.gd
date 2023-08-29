extends Node2D
class_name Maze

const ROOM = preload("res://Room/Room.tscn")

@export var bounds: Vector2i = Vector2i(8, 8)
@export var separation: int = 64

var maze_offset: Vector2i = Vector2i(128, 128)
var visited_rooms: Array[Room]
var playhead: Vector2i = Vector2i.ZERO


func _ready():
	CreateMaze()


func CreateMaze():
	var room_count: int = 0
	var total_rooms: int = bounds.x * bounds.y
	
	
	while room_count < total_rooms:
		await get_tree().create_timer(0.3).timeout
		
		
		
		
		# Add new room.
		# Start in one spot.
		var room = ROOM.instantiate()
		add_child(room)
		room_count += 1
		
		
		# Find grid position.
		print("PLAYHEAD: ", playhead)
		room.grid_position = playhead
		room.position = playhead * separation + maze_offset
		
		# Close all the doors around the edges of the maze.
		if room.grid_position.x <= 0:
			room.HideDoor(Room.Door.WEST)
		if room.grid_position.x > bounds.x - 2:
			room.HideDoor(Room.Door.EAST)
		if room.grid_position.y <= 0:
			room.HideDoor(Room.Door.NORTH)
		if room.grid_position.y > bounds.y - 2:
			room.HideDoor(Room.Door.SOUTH)
	
	
		# Lookaround on the room.
		# Returns doors[]
#		var random_room = room.doors.pick_random()
		if room.doors.is_empty():
			print("We hit a dead end.")
			return
		else:
			var rando: int = randi_range(0, room.doors.size() - 1)
			# Pop(): remove a `door` from the `doors` array.
			var direction = room.doors[rando]
			
			# Reposition the playhead for the next loop.
			match direction:
				Room.Door.NORTH:
					room.ShowDoor(Room.Door.NORTH)
					playhead.y -= 1
				Room.Door.EAST:
					room.ShowDoor(Room.Door.EAST)
					playhead.x += 1
				Room.Door.SOUTH:
					room.ShowDoor(Room.Door.SOUTH)
					playhead.y += 1
				Room.Door.WEST:
					room.ShowDoor(Room.Door.WEST)
					playhead.x -= 1
			
#			room.HideDoor(direction)
			
		
		# Increment `room_count`.
#		room_count += 1
	
	

	
	
	
	# Standard left-to-right the down.
#	for height_index in size.y:
#		for width_index in size.x:
#			await timer.timeout
#
#			var room = ROOM.instantiate()
#			visited_rooms.append(room)
#
#			add_child(room)
			
#			var new_door: Room.Door = room.RandomDirection()
#			match new_door:
#				Room.Door.NORTH:
#					room.ShowDoor(Room.Door.NORTH)
#					height_index -= 1
#				Room.Door.EAST:
#					room.ShowDoor(Room.Door.EAST)
#					width_index += 1
#				Room.Door.SOUTH:
#					room.ShowDoor(Room.Door.SOUTH)
#					height_index += 1
#				Room.Door.WEST:
#					room.ShowDoor(Room.Door.WEST)
#					width_index -= 1
			
			
