extends Node2D

class_name Projectile

@export var damage: float = 0.2
@export var speed: float = 200
@export var range: float = 300

var direction: Vector2
var distance_traveled: float = 0

func setup(origin: Vector2, dir: Vector2):
	position = origin
	direction = dir

func _physics_process(delta):
	position += Vector2(speed * direction.x * delta, speed * direction.y * delta)
	
	distance_traveled += speed * delta
	if distance_traveled > range:
		queue_free()

func change_direction(dir: Vector2):
	direction = dir
