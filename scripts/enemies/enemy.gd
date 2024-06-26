extends CharacterBody2D

class_name Enemy

@export var sprite: AnimatedSprite2D
@export var speed: float = 40
@export var acceleration: float = 100.0
@export var player_distance: float = 5.0
@export var health: float = 3.0
@export var weight: float = 100.0
@export var exp_points: float = 10.0

@onready var player: Player = %Player

var ilimited_speed: bool = false
var staggered: bool = false

func get_weight() -> float:
	return weight

func _physics_process(delta):
	if velocity.length() < speed:
		ilimited_speed = false
	
	if staggered:
		velocity = Vector2(0, 0)
	else:
		move(delta)
	
	move_and_slide()

func move(_delta: float):
	pass

func take_damage(dmg: float = 1):
	health -= dmg
	flash_white()
	
	if health <= 0:
		die()

func die():
	sprite.play("death")
	
	if not sprite.animation_finished.is_connected(queue_free):
		sprite.animation_finished.connect(queue_free)
		disable_colliders()

func flash_white():
	var shader = sprite.material
	
	if shader is ShaderMaterial:
		shader.set_shader_parameter("white", true)
		await get_tree().create_timer(0.1).timeout
		shader.set_shader_parameter("white", false)

func disable_colliders():
	for collision_shape: CollisionShape2D in find_children("CollisionShape2D"):
		collision_shape.set_deferred("disabled", true)
