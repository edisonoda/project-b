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
	sprite.speed_scale = 1
	scarab.speed -= speed_difference
	scarab.acceleration += acc_difference
	scarab.ilimited_speed = true
	
	if scarab.retreat_area.overlaps_body(player):
		scarab.change_state("retreating")
	else:
		scarab.change_state("chasing")
