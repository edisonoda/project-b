extends Node2D

class_name Gun

@export_global_file(".tscn") var projectile_path: String = "res://scenes/projectiles/rifle_bullet.tscn"
@export_node_path("Node2D") var reticle_path
@export_node_path("Marker2D") var shoot_path
@export_node_path("AnimatedSprite2D") var animation_path
@export_node_path("PointLight2D") var light_path
@export var fire_rate: float = 8
@export var reload_time: float = 1.5
@export var max_ammo: int = 20

@onready var projectile: Resource = load(projectile_path)
@onready var reticle: Node2D = get_node(reticle_path)
@onready var shoot_point: Marker2D = get_node(shoot_path)
@onready var animation: AnimatedSprite2D = get_node(animation_path)
@onready var light: PointLight2D = get_node(light_path)

var fire_rate_timer: Repeater = Repeater.new()
var reload_timer: Repeater = Repeater.new()

var ammo: int = max_ammo

func _ready():
	fire_rate_timer.setup(self, 1 / fire_rate)
	reload_timer.setup(self, reload_time)
	reload_timer.timeout.connect(on_reload_end)

func _process(_delta):
	var mouse = get_global_mouse_position()
	reticle.global_position = mouse
	
	look_at(mouse)

func shoot():
	light.enabled = true
	
	var stop_shooting = func():
		animation.play("not_shooting")
		light.enabled = false
	
	animation.animation_finished.connect(stop_shooting)
	animation.play("shooting")
	
	#GameManager.shake_camera()
	spawn_bullet()
	if ammo <= 0:
		reload()
	else:
		fire_rate_timer.restart()

func spawn_bullet():
	var dir = (get_global_mouse_position() - global_position).normalized()
	var proj = projectile.instantiate()
	proj.setup(shoot_point.global_position, dir)
	get_tree().root.add_child(proj)
	ammo -= 1

func reload():
	reload_timer.restart()

func check_shoot():
	return not fire_rate_timer.running and not reload_timer.running and ammo > 0

func check_reload():
	return not reload_timer.running

func on_reload_end():
	ammo = max_ammo

func delete_bullet(body: Node2D):
	body.queue_free()
