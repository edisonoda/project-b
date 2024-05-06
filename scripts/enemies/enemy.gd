extends Node2D

class_name Enemy

@export var SPEED: float = 0.5
@export var ACCELERATION: float = 1.0
@export var PLAYER_DISTANCE: float = 5.0
@export var HEALTH: float = 3.0
@export var WEIGHT: float = 5.0
@export var EXP: float = 10.0

@onready var player = %Player

var velocity: Vector2 = Vector2(0.0, 0.0)
var knockback_staggered: bool = false

func get_weight() -> float:
	return WEIGHT

func _physics_process(delta):
	if velocity.length() < SPEED:
		knockback_staggered = false
	
	move(delta)
	position.x += velocity.x
	position.y += velocity.y

func move(delta):
	pass
