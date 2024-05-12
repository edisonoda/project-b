extends Effect

class_name Sparking

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var light: PointLight2D = $Light

var flashing: bool = true
var enemy: Enemy

func _ready():
	super()
	sprite.frame_changed.connect(flash)

func with_data(e: Enemy, dur: float) -> Sparking:
	duration = dur
	enemy = e
	return self

func flash():
	flashing = sprite.frame % 2
	light.enabled = flashing

func on_ready():
	enemy.staggered = true

func on_end():
	enemy.staggered = false
