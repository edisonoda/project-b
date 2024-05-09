extends ScarabState

class_name ScarabAttackingState

var timer: Timer = Timer.new()

func _ready():
	sprite.play("walking")
	sprite.speed_scale = 2.5
	scarab.danger_zone.monitoring = true
	
	scarab.speed += speed_difference
	scarab.acceleration -= acc_difference
	
	timer.wait_time = attacking_time
	timer.timeout.connect(start_chasing)
	add_child(timer)
	timer.start()

func start_chasing():
	scarab.ilimited_speed = true
	scarab.change_state("chasing")
