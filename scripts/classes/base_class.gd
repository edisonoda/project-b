extends Node2D

class_name BaseClass

@export_file("*.tres") var sheet: String = "res://assets/Soldiers/assault_frames.tres"
@export_file("*.tscn") var gun_path: String = "res://scenes/guns/rifle.tscn"
@export var health: int = 3
@export var speed: float = 3000.0
@export var dash_cooldown: float = 2.0
@export var ability_cooldown: float = 5.0
@export var dash_force_ratio: float = 0.05

@onready var gun: Resource = load(gun_path)

var player: Player
var dash_timer: Repeater = Repeater.new()
var ability_timer: Repeater = Repeater.new()

var dashing_force: float

func _ready():
	dash_timer.setup(self, dash_cooldown)
	dash_timer.timeout.connect(dash_finished)
	
	ability_timer.setup(self, ability_cooldown)
	ability_timer.timeout.connect(ability_finished)

func _process(_delta):
	if not player.state is PlayerDashingState:
		return
	
	if player.velocity.length() < player.speed / 50:
		player.change_state("normal")

func with_data(p: Player) -> AssaultClass:
	player = p
	dashing_force = player.speed * dash_force_ratio
	return self

func use_dash():
	if not dash_timer.running:
		dash()

func dash():
	dash_timer.restart()
	player.change_state("dashing")
	
	var direction = Input.get_vector("Walk Left", "Walk Right", "Walk Up", "Walk Down")
	player.velocity = Vector2(dashing_force * direction.x, dashing_force * direction.y)

func dash_finished():
	player.change_state("normal")

func use_ability():
	if not ability_timer.running:
		ability_timer.restart()
		ability()

func ability():
	pass

func ability_finished():
	pass
