extends CharacterBody2D

class_name Player

@onready var game_manager: GameManager = %GameManager
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var damaged_timer: Timer = $DamagedTimer

var speed = 3000.0
var max_health = 3
var health = max_health

var state: PlayerState
var state_factory: PlayerStateFactory

#var p_class: PClass
@onready var p_class: PClass = $AssaultClass
@onready var gun: Gun = $Rifle

func _ready():
	p_class.update_player(self)
	
	speed = p_class.speed
	max_health = p_class.health
	health = p_class.health
	
	state_factory = PlayerStateFactory.new()
	change_state("normal")

func _physics_process(_delta):
	move_and_slide()

func receive_damage(damage):
	state.receive_damage(damage)

func change_state(new_state_name: String):
	if state != null:
		state.queue_free()
	state = state_factory.get_state(new_state_name).new()
	state.setup(self, sprite, game_manager)
	add_child(state)

func _on_damaged_timer_timeout():
	sprite.modulate.g = 1.0
	sprite.modulate.b = 1.0
	
	if state is PlayerDamagedState:
		change_state("normal")
