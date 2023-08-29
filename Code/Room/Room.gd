extends Node2D
class_name Room

@onready var north_door = $NorthDoor
@onready var east_door = $EastDoor
@onready var south_door = $SouthDoor
@onready var west_door = $WestDoor

enum Door
{
	NORTH,
	EAST,
	SOUTH,
	WEST
}


# Initialize.
var grid_position: Vector2i
var doors: Array = [Door.NORTH, Door.EAST, Door.SOUTH, Door.WEST]
#var directions: Array[Vector2i] = [Vector2i(0, -1), Vector2i(+1, 0), Vector2i(0, +1), Vector2i(-1, 0)]


#func _ready():
#	for door in doors:
#		HideDoor(door)


#func RandomDirection():
#	var rando: int = randi_range(0, doors.size() - 1)
#	return doors.pop_at(rando)

#func GetDirection():
#	return Door.SOUTH
	


func ShowDoor(door: Door):
	match door:
		Door.NORTH:
			north_door.show()
			doors.append(Door.NORTH)
		Door.EAST:
			east_door.show()
			doors.append(Door.EAST)
		Door.SOUTH:
			south_door.show()
			doors.append(Door.SOUTH)
		Door.WEST:
			west_door.show()
			doors.append(Door.WEST)


func HideDoor(door: Door):
	match door:
		Door.NORTH:
			north_door.hide()
			doors.erase(Door.NORTH)
		Door.EAST:
			east_door.hide()
			doors.erase(Door.EAST)
		Door.SOUTH:
			south_door.hide()
			doors.erase(Door.SOUTH)
		Door.WEST:
			west_door.hide()
			doors.erase(Door.WEST)
