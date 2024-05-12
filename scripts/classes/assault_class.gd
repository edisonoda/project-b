extends BaseClass

class_name AssaultClass

const STRIKE_SCENE: PackedScene = preload("res://scenes/abilities/lightning_strike.tscn")

@export_range(0.1, 10) var duration: float = 5
@export_range(5, 100) var initial_area: float = 60
@export_range(5, 100) var strike_range: float = 40

func ability():
	var strike: LightningStrike = STRIKE_SCENE.instantiate()
	add_child(strike)
	strike.activate(duration, initial_area, strike_range)

func ability_finished():
	pass
