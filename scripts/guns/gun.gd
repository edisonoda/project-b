extends Node2D

class_name Gun

@export_global_file(".tscn") var projectile_path: String = "res://scenes/projectiles/rifle_bullet.tscn"
@export_node_path("Node2D") var reticle_path
@export_node_path("Marker2D") var shoot_point
@export var fire_rate: float = 5
@export var reload_time: float = 1.5
@export var max_ammo: int = 12

@onready var projectile: Resource = load(projectile_path)
@onready var reticle: Node2D = get_node(reticle_path)
@onready var origin: Vector2 = Vector2(0, 0)
#@onready var game_manager: GameManager = %GameManager

var fire_rate_timer: Repeater = Repeater.new()
var reload_timer: Repeater = Repeater.new()

var ammo: int = max_ammo

func _ready():
	fire_rate_timer.setup(self, 1 / fire_rate)
	reload_timer.setup(self, reload_time)
	reload_timer.timeout.connect(on_reload_end)
	
	if shoot_point:
		origin = get_node(shoot_point).position

func _process(delta):
	var mouse = get_local_mouse_position()
	reticle.position = mouse
	
	if not reload_timer.running and Input.is_action_pressed("Reload"):
		reload()
	
	if check_shoot() and Input.is_action_pressed("Shoot"):
		shoot((mouse - position).normalized())

func check_shoot():
	return not fire_rate_timer.running and not reload_timer.running and ammo > 0

func shoot(dir: Vector2):
	var proj = projectile.instantiate()
	proj.setup(dir, origin)
	add_child(proj)
	ammo -= 1
	
	#game_manager.shake()
	if ammo <= 0:
		reload()
	else:
		fire_rate_timer.restart()

func reload():
	reload_timer.restart()

func on_reload_end():
	ammo = max_ammo
