extends Enemy

class_name Scarab

@export var speed_difference: float = 140
@export var acceleration_difference: float = 30
@export var attacking_time: float = 3.5

@onready var danger_zone: Area2D = $DangerZone
@onready var charge_area: Area2D = $ChargeArea
@onready var retreat_area = $RetreatArea

var state: ScarabState
var state_factory: ScarabStateFactory

func _ready():
	state_factory = ScarabStateFactory.new()
	change_state("chasing")

func move(delta: float):
	if health <= 0 or position.distance_to(player.position) < player_distance:
		velocity = Vector2(0.0, 0.0)
		return
	
	state.move(delta)
	sprite.flip_h = player.global_position.x < global_position.x

func die():
	sprite.speed_scale = 1
	super()

func change_state(new_state_name: String):
	if state != null:
		state.queue_free()
	state = state_factory.get_state(new_state_name).new()
	state.setup(self, player, sprite)
	add_child(state)
