extends Node2D

class_name Gun

const MAX_PITCH = 3

@export_global_file(".tscn") var projectile_path: String = "res://scenes/projectiles/rifle_bullet.tscn"
@export_global_file(".wav") var reload_stream_path: String = "res://assets/Sounds/sfx/Sci Fi Weapons Cyberpunk Arsenal Preview/AUDIO/GUNMech_Insert Clip_04.wav"
@export_global_file(".wav") var finished_reload_stream_path: String = "res://assets/Sounds/sfx/Sci Fi Weapons Cyberpunk Arsenal Preview/AUDIO/GUNMech_Mechanical_12.wav"
@export_node_path("Node2D") var reticle_path
@export_node_path("Marker2D") var shoot_path
@export_node_path("AnimatedSprite2D") var animation_path
@export_node_path("PointLight2D") var light_path
@export_node_path("AudioStreamPlayer2D") var shooting_audio_player_path
@export_node_path("AudioStreamPlayer2D") var reload_audio_player_path
@export_node_path("RadialProgress") var reload_progress_path
@export var fire_rate: float = 5
@export var reload_time: float = 1.5
@export var max_ammo: int = 20

@onready var projectile: Resource = load(projectile_path)
@onready var reload_stream: Resource = load(reload_stream_path)
@onready var finished_reload_stream: Resource = load(finished_reload_stream_path)
@onready var reticle: Node2D = get_node(reticle_path)
@onready var shoot_point: Marker2D = get_node(shoot_path)
@onready var animation: AnimatedSprite2D = get_node(animation_path)
@onready var light: PointLight2D = get_node(light_path)
@onready var shooting_audio_player: AudioStreamPlayer2D = get_node(shooting_audio_player_path)
@onready var reload_audio_player: AudioStreamPlayer2D = get_node(reload_audio_player_path)
@onready var reload_progress: RadialProgress = get_node(reload_progress_path)

var fire_rate_timer: Repeater = Repeater.new()
var reload_timer: Repeater = Repeater.new()
var reload_pitch_scale: float

var ammo: int = max_ammo

func _ready():
	setup()

func _process(delta):
	var mouse = get_global_mouse_position()
	reticle.global_position = mouse
	look_at(mouse)
	
	if reload_timer.running:
		reload_progress.progress += (1 / reload_time) * delta * 100

func setup():
	fire_rate_timer.setup(self, 1 / fire_rate)
	reload_timer.setup(self, reload_time)
	reload_timer.timeout.connect(on_reload_end)
	
	reload_pitch_scale = clamp(reload_stream.get_length() / reload_time, 0.75, 1.25)

func shoot():
	var stop_shooting = func(): animation.play("not_shooting")
	animation.animation_finished.connect(stop_shooting)
	animation.play("shooting")
	shooting_audio_player.play()
	
	#GameManager.shake_camera()
	spawn_bullet()
	flash_light()
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

func flash_light():
	light.enabled = true
	await get_tree().create_timer(0.1).timeout
	light.enabled = false

func reload():
	reload_audio_player.stream = reload_stream
	reload_audio_player.pitch_scale = reload_pitch_scale
	reload_audio_player.play()
	reload_timer.restart()

func check_shoot():
	return not fire_rate_timer.running and not reload_timer.running and ammo > 0

func check_reload():
	return not reload_timer.running and not ammo == max_ammo

func on_reload_end():
	reload_audio_player.stream = finished_reload_stream
	reload_audio_player.pitch_scale = 1
	reload_audio_player.play()
	reload_progress.progress = 0
	ammo = max_ammo

func delete_bullet(body: Node2D):
	body.queue_free()
