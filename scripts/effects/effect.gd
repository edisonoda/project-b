extends Node2D

class_name Effect

@export_range(0.1, 10) var duration: float = 1

var timer: Repeater = Repeater.new()

func _ready():
	timer.timeout.connect(timeout)
	on_ready()

func _process(delta):
	on_process(delta)

func _physics_process(delta):
	on_physics_process(delta)

func start(dur: float = duration):
	duration = dur
	timer.setup(self, duration)
	timer.restart()

func extend(dur: float):
	timer.wait_time += dur

func timeout():
	on_end()
	queue_free()

func on_end():
	pass

func on_ready():
	pass

func on_process(_delta: float):
	pass

func on_physics_process(_delta: float):
	pass
