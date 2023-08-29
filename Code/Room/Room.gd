extends Node2D
class_name Room

@onready var north_passage = $NorthPassage
@onready var east_passage = $EastPassage
@onready var south_passage = $SouthPassage
@onready var west_passage = $WestPassage


enum Passage
{
	NORTH,
	EAST,
	SOUTH,
	WEST
}


# Initialize.
var grid_position: Vector2i
#var doors: Array = []
#var directions: Array[Vector2i] = [Vector2i(0, -1), Vector2i(+1, 0), Vector2i(0, +1), Vector2i(-1, 0)]


func _ready():
	# Hide graphics.
	north_passage.hide()
	east_passage.hide()
	south_passage.hide()
	west_passage.hide()


#func RandomDirection():
#	var rando: int = randi_range(0, doors.size() - 1)
#	return doors.pop_at(rando)


#func GetDirection():
#	return Door.SOUTH


func OpenPassage(passage: Passage):
	match passage:
		Passage.NORTH:
			north_passage.show()
		Passage.EAST:
			east_passage.show()
		Passage.SOUTH:
			south_passage.show()
		Passage.WEST:
			west_passage.show()
