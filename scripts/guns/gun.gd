extends Node2D

class_name Gun

@export_node_path("Node2D") var reticle_path
@export var fire_rate: float = 5
@export var reload_time: float = 1.5
@export var max_ammo: int = 12

@onready var reticle: Node2D = get_node(reticle_path)
@onready var game_manager: GameManager = %GameManager

var fire_rate_timer: Timer = Timer.new()
var reload_timer: Timer = Timer.new()

var ammo: int = max_ammo

func _ready():
	fire_rate_timer.wait_time = 1 / fire_rate
	reload_timer.wait_time = reload_time

func _physics_process(delta):
	var mouse = get_local_mouse_position()
	reticle.position = mouse

func _process(delta):
	if Input.is_action_pressed("Shoot") and check_shoot():
		game_manager.shake()
		on_shoot()

func check_shoot():
	return fire_rate_timer.is_stopped() and reload_timer.is_stopped() and ammo > 0

func on_shoot():
	pass
