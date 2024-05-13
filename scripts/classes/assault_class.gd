extends BaseClass

class_name AssaultClass

const STRIKE_SCENE: PackedScene = preload("res://scenes/abilities/lightning_strike.tscn")

@export_range(0.1, 10) var duration: float = 1
@export_range(0.1, 10) var charge_time: float = 1
@export_range(5, 100) var strike_range: float = 70

func ability():
	var strike: LightningStrike = STRIKE_SCENE.instantiate()
	add_child(strike)
	strike.activate(duration, strike_range, charge_time)

func ability_finished():
	pass
