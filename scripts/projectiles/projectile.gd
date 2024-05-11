extends Node2D

class_name Projectile

@export var damage: float = 0.4
@export var speed: float = 350
@export var max_range: float = 300

var direction: Vector2
var distance_traveled: float = 0

func setup(origin: Vector2, ang: float):
	position = origin
	rotation = ang
	direction = Vector2(cos(ang), sin(ang))

func _physics_process(delta):
	position += Vector2(speed * direction.x * delta, speed * direction.y * delta)
	
	distance_traveled += speed * delta
	if distance_traveled > max_range:
		queue_free()

func change_direction(dir: Vector2):
	direction = dir

func _on_body_entered(body: Node2D):
	queue_free()
	
	if body.has_method("take_damage"):
		body.take_damage(damage)
