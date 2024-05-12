extends Node2D

class_name LightningStrike

const ANIMATION_SCENE: PackedScene = preload("res://scenes/utils/one_shot_animation.tscn")
const STRIKE_SCENE: PackedScene = preload("res://scenes/abilities/strike_area.tscn")
const SPARKING_SCENE: PackedScene = preload("res://scenes/effects/sparking.tscn")
const STRIKE: SpriteFrames = preload("res://assets/Effects/lightning_strike.tres")
const CHAIN: SpriteFrames = preload("res://assets/Effects/lightning_chain.tres")

var duration: float = 3
var chain_range: float = 10

var affected: Dictionary = {}
var queue: Dictionary = {}
var strike_queue: Dictionary = {}

func _ready():
	set_process(false)

func _process(_delta):
	#if queue.size() == 0:
		#queue_free()
	
	pass

func activate(dur: float, area: float, radius: float):
	set_process(true)
	duration = dur
	chain_range = radius
	detect(global_position, first_strike, area)

func detect(pos: Vector2, callback: Callable, radius: float = chain_range):
	var strike_area: StrikeArea = STRIKE_SCENE.instantiate().with_data(pos, radius)
	get_tree().root.add_child(strike_area)
	
	var entered: Callable = func call(_body):
		for enemy in strike_area.get_overlapping_bodies():
			if enemy.get_instance_id() not in affected:
				callback.call(pos, enemy)
		
		strike_area.queue_free()
	
	strike_area.body_entered.connect(entered)

func chain(pos: Vector2, target: Enemy):
	var dis: float = pos.distance_to(target.global_position)
	var dir: Vector2 = pos.direction_to(target.global_position)
	var size: float = clamp(dis / 40, 0.5, 1.5)
	var animation: OneShotAnimation = ANIMATION_SCENE.instantiate().with_data(pos + (dis * dir) / 2, CHAIN)
	animation.rotation = dir.angle() + 0.75 * PI
	animation.scale = Vector2(size, size)
	queue[animation.get_instance_id()] = animation
	get_tree().root.add_child(animation)
	
	var callback: Callable = func call():
		queue.erase(animation.get_instance_id())
		strike(target)
	
	animation.animation_finished.connect(callback)

func strike(target: Enemy):
	if target.staggered:
		target.get_node("Sparking").extend(duration)
	else:
		var sparking: Sparking = SPARKING_SCENE.instantiate().with_data(target, duration)
		target.add_child(sparking)
		sparking.start()
	
	affected[target.get_instance_id()] = target
	detect(target.global_position, chain)
	
func first_strike(_pos: Vector2, target: Enemy):
	var animation: OneShotAnimation = ANIMATION_SCENE.instantiate().with_data(target.global_position, STRIKE)
	queue[animation.get_instance_id()] = animation
	get_tree().root.add_child(animation)
	
	var callback: Callable = func call():
		queue.erase(animation.get_instance_id())
		strike(target)
	
	animation.animation_finished.connect(callback)
