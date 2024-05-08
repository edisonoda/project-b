extends Node

class_name PClass

@export_file("*.png") var sheet: String = "res://assets/Soldiers/Assault-Class.png"
@export var health: int = 3
@export var speed: float = 3000.0
@export var ability_cooldown: float = 2.0

var player: Player
var ability_timer: Repeater = Repeater.new()
var ability_recharging_time: float = 0.0

func _ready():
	ability_timer.setup(self, ability_cooldown)
	ability_timer.timeout.connect(ability_finished)

func use_ability():
	if not ability_timer.running:
		ability()

func ability():
	pass

func update_player(p):
	player = p
	player_updated()

func player_updated():
	pass

func ability_finished():
	pass
