extends Node2D

class_name Gun

@export_global_file(".tscn") var projectile_path: String = "res://scenes/projectiles/rifle_bullet.tscn"
@export_node_path("Node2D") var reticle_path
@export var fire_rate: float = 5
@export var reload_time: float = 1.5
@export var max_ammo: int = 12

@onready var projectile: Resource = load(projectile_path)
@onready var reticle: Node2D = get_node(reticle_path)
#@onready var game_manager: GameManager = %GameManager

var fire_rate_timer: Timer = Timer.new()
var reload_timer: Timer = Timer.new()

var ammo: int = max_ammo

func _ready():
	fire_rate_timer.wait_time = 1 / fire_rate
	reload_timer.wait_time = reload_time

func _process(delta):
	var mouse = get_local_mouse_position()
	reticle.position = mouse
	
	if (Input.is_action_pressed("Reload") or ammo <= 0) and reload_timer.time_left == 0:
		reload()
	
	if Input.is_action_pressed("Shoot") and check_shoot():
		shoot((mouse - position).normalized())

func check_shoot():
	return fire_rate_timer.time_left == 0 and reload_timer.time_left == 0 and ammo > 0

func shoot(dir: Vector2):
	var proj = projectile.instantiate()
	proj.setup(dir)
	add_child(proj)
	on_shoot()
	ammo -= 1
	
	#game_manager.shake()
	fire_rate_timer.start()

func on_shoot():
	pass

func reload():
	reload_timer.start()

func on_reload_end():
	ammo = max_ammo
