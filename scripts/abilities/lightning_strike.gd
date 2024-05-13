extends Node2D

class_name LightningStrike

const ANIMATION_SCENE: PackedScene = preload("res://scenes/utils/one_shot_animation.tscn")
const STRIKE_SCENE: PackedScene = preload("res://scenes/abilities/strike_area.tscn")
const SPARKING_SCENE: PackedScene = preload("res://scenes/effects/sparking.tscn")
const STRIKE: SpriteFrames = preload("res://assets/Effects/lightning_strike.tres")

@onready var thunder_sound: AudioStreamPlayer = $ThunderSound
@onready var shock_sound: AudioStreamPlayer = $ShockSound

var radius: float = 50
var duration: float = 1

func activate(dur: float, rad: float, charge: float):
	duration = dur
	radius = rad
	detect(charge)

func detect(charge: float):
	var strike_area: StrikeArea = STRIKE_SCENE.instantiate().with_data(radius, charge)
	add_child(strike_area)
	
	var entered: Callable = func call():
		thunder_sound.play()
		shock_sound.play()
		
		for enemy in strike_area.get_overlapping_bodies():
			strike(enemy)
		
		strike_area.queue_free()
		await get_tree().create_timer(0.1).timeout
		EventManager.restore_canvas_module()
	
	strike_area.charged.connect(entered)

func strike(target: Enemy):
	var animation: OneShotAnimation = ANIMATION_SCENE.instantiate().with_data(STRIKE)
	animation.scale = target.scale * 0.75
	target.add_child(animation)
	set_sparked(target)

func set_sparked(target: Enemy):
	if target.staggered:
		target.get_node("Sparking").extend(duration)
	else:
		var sparking: Sparking = SPARKING_SCENE.instantiate().with_data(target, duration)
		target.add_child(sparking)
		sparking.start()
