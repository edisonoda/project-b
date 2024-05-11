extends LightOccluder2D

@onready var sprite: Node2D = get_parent()

func _ready():
	if not sprite or (not sprite is Sprite2D and not sprite is AnimatedSprite2D):
		set_process(false)

func _process(delta):
	if sprite.flip_h:
		scale.x = -1
	else:
		scale.x = 1
