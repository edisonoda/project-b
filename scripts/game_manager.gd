extends Node2D

class_name GameManager

const KNOCKBACK_FORCE = 7500.0

@onready var game_over_timer = $GameOverTimer
@onready var enemies = %Enemies
@onready var player = %Player

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func global_knockback():
	var children = enemies.get_children()
	var acceleration
	var direction
	
	for child in children:
		acceleration = KNOCKBACK_FORCE/child.get_weight()
		direction = player.position.direction_to(child.position)
		child.velocity = Vector2(acceleration * direction.x, acceleration * direction.y)
		child.ilimited_speed = true

func game_over():
	game_over_timer.start()
	Engine.time_scale = 0.3

func shake_camera(intensity: float = 1):
	#TODO
	pass

func _on_game_over_timer_timeout():
	get_tree().reload_current_scene()
	Engine.time_scale = 1
