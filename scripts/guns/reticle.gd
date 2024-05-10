extends Node2D

class_name Reticle

@export var fire_rate: float = 5
##Número de tiros consecutivos para deixar a animação 100%
@export var max_shots: int = 10

@onready var animation: AnimationPlayer = $AnimationPlayer

func _ready():
	animation.play("shoot")

func _physics_process(delta):
	animation.advance(-delta)

func play():
	animation.advance(1 / float(max_shots) + 1 / fire_rate)
