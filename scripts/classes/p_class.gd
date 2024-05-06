extends Node

class_name PClass

@export_file("*.png") var sheet: String = "res://assets/Soldiers/Assault-Class.png"
@export var health: int = 3
@export var speed: float = 3000.0
@export var ability_cooldown: float = 2.0

var player: Player
var ability_timer: Timer = Timer.new()
var ability_recharging_time: float = 0.0

func _ready():
	ability_timer.timeout.connect(ability_finished)
	ability_timer.wait_time = ability_cooldown

func use_ability():
	if ability_timer.is_stopped():
		ability()

func ability():
	pass

func change_cooldown(cd):
	ability_cooldown = cd

func update_player(p):
	player = p
	player_updated()

func player_updated():
	pass

func ability_finished():
	pass
