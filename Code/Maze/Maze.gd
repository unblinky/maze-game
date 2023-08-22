extends Node2D
class_name Maze

const ROOM = preload("res://Room/Room.tscn")


@onready var timer = $Timer


@export var size: Vector2i = Vector2i(3, 4)
@export var separation: int = 64

var maze_offset: Vector2i = Vector2i(128, 128)
var rooms: Array[Room]
var visited_rooms: Array[Room]


func _ready():
	CreateMaze()


func CreateMaze():
	for height_index in size.y:
		for width_index in size.x:
			await timer.timeout
			
			var room = ROOM.instantiate()
			visited_rooms.append(room)
			
			add_child(room)
			
			var new_door: Room.Door = room.RandomDirection()
			match new_door:
				Room.Door.NORTH:
					room.ShowDoor(Room.Door.NORTH)
					height_index -= 1
				Room.Door.EAST:
					room.ShowDoor(Room.Door.EAST)
					width_index += 1
				Room.Door.SOUTH:
					room.ShowDoor(Room.Door.SOUTH)
					height_index += 1
				Room.Door.WEST:
					room.ShowDoor(Room.Door.WEST)
					width_index -= 1
			
			room.position.x = width_index * separation + maze_offset.x
			room.position.y = height_index * separation + maze_offset.y
			
			
			
			# Handle the width.
			if width_index <= 0:
				room.HideDoor(Room.Door.WEST)
			if width_index > size.x - 2:
				room.HideDoor(Room.Door.EAST)
			
			# Handle the height.
			if height_index <= 0:
				room.HideDoor(Room.Door.NORTH)
			if height_index > size.y - 2:
				room.HideDoor(Room.Door.SOUTH)
			rooms.append(room)
	
	rooms[0].ShowDoor(Room.Door.NORTH)
	#for room in Rooms:
		
