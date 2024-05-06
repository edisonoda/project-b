extends Node2D

class_name Projectile

@export var damage: float = 0.2
@export var speed: float = 200

var direction: Vector2

func setup(dir: Vector2):
	direction = dir

func _physics_process(delta):
	position += Vector2(speed * direction.x * delta, speed * direction.y * delta)

func change_direction(dir: Vector2):
	direction = dir
