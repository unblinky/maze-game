extends Node2D
class_name Maze

const ROOM = preload("res://Room/Room.tscn")


@onready var timer = $Timer


@export var size: Vector2i = Vector2i(3, 4)
@export var separation: int = 128



func _ready():
	CreateMaze()


func CreateMaze():
	for height_index in size.y:
		for width_index in size.x:
			await timer.timeout
			
			var room = ROOM.instantiate()
			room.position.x = width_index * separation
			room.position.y = height_index * separation
			add_child(room)
			
			
