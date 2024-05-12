extends Area2D

class_name StrikeArea

@onready var area: CollisionShape2D = $Area

var detected: Array[Enemy]
var radius: float = 10

func _ready():
	area.shape.radius = radius

func with_data(pos: Vector2, rad: float) -> StrikeArea:
	global_position = pos
	radius = rad
	return self
