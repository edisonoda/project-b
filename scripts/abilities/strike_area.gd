extends Area2D

class_name StrikeArea

signal charged

@export var thunder_color: Color = Color("0a0a0a")

@onready var area: CollisionShape2D = $Area
@onready var sprite: Sprite2D = %Sprite
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var color_step: Color = Constants.CANVAS_COLOR - thunder_color

var detected: Array[Enemy]
var radius: float = 10
var charge_time: float = 1

func _ready():
	area.shape.radius = radius
	sprite.scale *= radius / 10
	
	animation.speed_scale = 1 / charge_time
	animation.play("charge")

func _process(delta):
	var color = Color(color_step, 0) * (delta / charge_time) * -1
	print(color)
	EventManager.modulate_canvas(color, false)

func with_data(rad: float, charge: float) -> StrikeArea:
	radius = rad
	charge_time = charge
	return self

func end_charge():
	EventManager.modulate_canvas(Color.WHITE)
	charged.emit()
