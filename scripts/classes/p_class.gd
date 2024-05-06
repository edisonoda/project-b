extends Node

class_name PClass

@export_file("*.png") var sheet: String = "res://assets/Soldiers/Assault-Class.png"
@export var health: int = 3
@export var speed: float = 3000.0
@export var ability_cooldown: float = 2.0

var player: Player
var ability_recharging_time: float = 0.0
var ability_started: bool = false

func _process(delta):
	if not ability_started:
		return
	
	ability_recharging_time += delta
	
	if ability_recharging_time > ability_cooldown:
		ability_recharging_time = 0.0
		ability_started = false
		ability_finished()

func use_ability():
	if ability_recharging_time == 0.0:
		ability_started = true
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
