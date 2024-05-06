extends Node2D

class_name Enemy

@export var speed: float = 0.5
@export var acceleration: float = 1.0
@export var player_distance: float = 5.0
@export var health: float = 3.0
@export var weight: float = 5.0
@export var exp: float = 10.0

@onready var player = %Player

var velocity: Vector2 = Vector2(0.0, 0.0)
var knockback_staggered: bool = false

func get_weight() -> float:
	return weight

func _physics_process(delta):
	if velocity.length() < speed:
		knockback_staggered = false
	
	move(delta)
	position.x += velocity.x
	position.y += velocity.y

func move(delta):
	pass
