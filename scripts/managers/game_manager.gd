extends Node2D

class_name GameManager

@export var knockback: float = 7500.0

@onready var game_over_timer = $GameOverTimer
@onready var enemies = %Enemies
@onready var player = %Player
@onready var canvas_modulate = %CanvasModulate

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	EventManager.screen_shaked.connect(shake_screen)
	EventManager.canvas_modulated.connect(modulate_canvas)
	EventManager.restored_canvas_module.connect(restore_canvas_module)

func global_knockback():
	var children = enemies.get_children()
	var acceleration
	var direction
	
	for child in children:
		acceleration = knockback / child.get_weight()
		direction = player.position.direction_to(child.position)
		child.velocity = Vector2(acceleration * direction.x, acceleration * direction.y)
		child.ilimited_speed = true

func game_over():
	game_over_timer.start()
	Engine.time_scale = 0.3

func shake_screen(trauma: float, power: float, decay: float):
	pass

func modulate_canvas(color: Color, absolute: bool):
	if absolute:
		canvas_modulate.color = color
	else:
		canvas_modulate.color += color

func restore_canvas_module():
	canvas_modulate.color = Constants.CANVAS_COLOR

func _on_game_over_timer_timeout():
	get_tree().reload_current_scene()
	Engine.time_scale = 1
