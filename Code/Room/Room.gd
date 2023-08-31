extends Node2D
class_name Room

@onready var passage_left = $PassageLeft
@onready var passage_right = $PassageRight
@onready var passage_up = $PassageUp
@onready var passage_down = $PassageDown

var grid: Vector2i

var color: Color:
	set(value):
		modulate = value


func _ready():
	# Hide graphics.
	passage_left.hide()
	passage_right.hide()
	passage_up.hide()
	passage_down.hide()


func OpenPassage(room: Room):
	if room.grid.x < grid.x:
		passage_left.show()
		room.passage_right.show()
	elif room.grid.x > grid.x:
		passage_right.show()
		room.passage_left.show()
	elif room.grid.y < grid.y:
		passage_up.show()
		room.passage_down.show()
	elif room.grid.y > grid.y:
		passage_down.show()
		room.passage_up.show()
