extends Node2D

class_name Gun

@export_global_file(".tscn") var projectile_path: String = "res://scenes/projectiles/rifle_bullet.tscn"
@export_node_path("Node2D") var reticle_path
@export_node_path("Marker2D") var shoot_path
@export var fire_rate: float = 5
@export var reload_time: float = 1.5
@export var max_ammo: int = 12

@onready var projectile: Resource = load(projectile_path)
@onready var reticle: Node2D = get_node(reticle_path)
@onready var shoot_point: Node2D = get_node(shoot_path)
#@onready var game_manager: GameManager = %GameManager

var fire_rate_timer: Repeater = Repeater.new()
var reload_timer: Repeater = Repeater.new()

var ammo: int = max_ammo

func _ready():
	fire_rate_timer.setup(self, 1 / fire_rate)
	reload_timer.setup(self, reload_time)
	reload_timer.timeout.connect(on_reload_end)

func _process(_delta):
	var mouse = get_local_mouse_position()
	reticle.position = mouse

func shoot():
	if not check_shoot():
		return
	
	var dir = (get_local_mouse_position() - position).normalized()
	var proj = projectile.instantiate()
	proj.setup(dir, shoot_point.position)
	add_child(proj)
	ammo -= 1
	
	#game_manager.shake()
	if ammo <= 0:
		reload()
	else:
		fire_rate_timer.restart()

func reload():
	if not reload_timer.running:
		reload_timer.restart()

func check_shoot():
	return not fire_rate_timer.running and not reload_timer.running and ammo > 0

func on_reload_end():
	ammo = max_ammo
