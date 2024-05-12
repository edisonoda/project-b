extends CharacterBody2D

class_name Player

@onready var game_manager: GameManager = %GameManager
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var damaged_timer: Timer = $DamagedTimer
@onready var gun_origin = $GunOrigin

var speed = 3000.0
var max_health = 3
var health = max_health

var state: PlayerState
var state_factory: PlayerStateFactory

var p_class: BaseClass
var gun: Gun

func _ready():
	set_class(preload("res://scenes/classes/assault_class.tscn"))
	set_gun(preload("res://scenes/guns/rifle.tscn"))
	
	speed = p_class.speed
	max_health = p_class.health
	health = p_class.health
	
	state_factory = PlayerStateFactory.new()
	change_state("normal")

func _physics_process(_delta):
	move_and_slide()

func set_class(c: Resource):
	p_class = c.instantiate()
	p_class.update_player(self)
	add_child(p_class)
	
	sprite.sprite_frames = load(p_class.sheet)

func set_gun(g: Resource):
	gun = g.instantiate()
	gun_origin.add_child(gun)

func receive_damage(damage):
	state.receive_damage(damage)

func change_state(new_state_name: String):
	if state != null:
		state.queue_free()
	state = state_factory.get_state(new_state_name).new()
	state.setup(self, sprite, game_manager)
	add_child(state)

func _on_damaged_timer_timeout():
	sprite.modulate = Color.WHITE
	
	if state is PlayerDamagedState:
		change_state("normal")
