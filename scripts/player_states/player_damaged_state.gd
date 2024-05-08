extends PlayerNormalState

class_name PlayerDamagedState

const BLINKING_TIME = 0.2

var blinking_timer: Repeater = Repeater.new()
var blinked: bool = false

func _ready():
	game_manager.global_knockback(player.position)
	
	blinking_timer.setup(self, BLINKING_TIME)
	blinking_timer.timeout.connect(blink)
	
	blink()

func blink():
	if blinked:
		sprite.modulate.g = 1.0
		sprite.modulate.b = 1.0
	else:
		sprite.modulate.g = 0.0
		sprite.modulate.b = 0.0
	
	blinked = !blinked
	blinking_timer.restart()

func receive_damage(_damage):
	pass
