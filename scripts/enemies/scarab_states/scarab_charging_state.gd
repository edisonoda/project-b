extends ScarabState

class_name ScarabChargingState

func _ready():
	sprite.play("preparing_attack")
	sprite.animation_finished.connect(attack)

func move(_delta: float):
	if not scarab.ilimited_speed:
		scarab.velocity = Vector2(0, 0)

func attack():
	scarab.change_state("attacking")
