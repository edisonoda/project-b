extends Node2D

class_name Gun

const MAX_PITCH = 3

@export_file("*.tscn") var projectile_path: String = "res://scenes/projectiles/rifle_bullet.tscn"
@export_file("*.wav") var reload_stream_path: String = "res://assets/Sounds/sfx/Guns/rifle_reload.wav"
@export_file("*.wav") var finished_reload_stream_path: String = "res://assets/Sounds/sfx/Guns/rifle_finished_reload.wav"

@onready var projectile: Resource = load(projectile_path)
@onready var reload_stream: Resource = load(reload_stream_path)
@onready var finished_reload_stream: Resource = load(finished_reload_stream_path)

@export var reticle: Reticle
@export var shoot_point: Marker2D
@export var animation: AnimatedSprite2D
@export var light: PointLight2D
@export var shooting_audio_player: AudioStreamPlayer2D
@export var reload_audio_player: AudioStreamPlayer2D
@export var reload_progress: RadialProgress

@export_range(0.1, 20) var fire_rate: float = 5
@export_range(0.1, 5) var reload_time: float = 1.5
@export_range(1, 100) var max_ammo: int = 20
@export_range(1, 20) var bullets_shot: int = 1
@export_range(0, 90) var spread: float = 5

@onready var radian_spread: float = spread * PI / 180
@onready var ammo: int = max_ammo

var fire_rate_timer: Repeater = Repeater.new()
var reload_timer: Repeater = Repeater.new()
var reload_pitch_scale: float

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
	
	reload_pitch_scale = clamp( reload_stream.get_length() / reload_time, 0.75, 1.25)

func shoot():
	var stop_shooting = func(): animation.play("not_shooting")
	animation.animation_finished.connect(stop_shooting)
	animation.play("shooting")
	shooting_audio_player.play()
	reticle.play()
	
	#GameManager.shake_camera()
	spread_bullets()
	flash_light()
	if ammo <= 0:
		reload()
	else:
		fire_rate_timer.restart()

func spread_bullets():
	var dir = (get_global_mouse_position() - global_position).angle()
	var a: float = dir - (radian_spread / 2.0)
	var b: float = radian_spread / bullets_shot
	ammo -= 1
	
	for i in bullets_shot:
		spawn_bullet(a + (i * b))

func spawn_bullet(ang):
	var proj = projectile.instantiate()
	proj.setup(shoot_point.global_position, ang)
	get_tree().root.add_child(proj)

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
