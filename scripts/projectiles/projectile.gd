extends RigidBody2D

class_name Projectile

@export_file("*.png") var sprite = "res://assets/Projectiles/bullets+plasma.png"
@export var damage: float = 0.5
@export var speed: float = 5000

var direction: Vector2

func _init(dir: Vector2):
	direction = dir

func _physics_process(delta):
	position += Vector2(speed * direction.x * delta, speed * direction.y * delta)

func change_direction(dir: Vector2):
	direction = dir
