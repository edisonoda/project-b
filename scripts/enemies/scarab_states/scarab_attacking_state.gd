extends ScarabState

class_name ScarabAttackingState

var attack_timer: Timer = Timer.new()

func _ready():
	sprite.play("walking")
	sprite.speed_scale = 2.5
	sprite.frame_changed.connect(play_step)
	
	scarab.danger_zone.monitoring = true
	scarab.speed += speed_difference
	scarab.acceleration -= acc_difference
	
	set_timer()

func set_timer():
	attack_timer.wait_time = attacking_time
	attack_timer.timeout.connect(start_chasing)
	add_child(attack_timer)
	attack_timer.start()

func play_step():
	if sprite.frame % 3:
		scarab.step.play()

func start_chasing():
	sprite.speed_scale = 1
	sprite.frame_changed.disconnect(play_step)
	scarab.step.stop()
	
	scarab.speed -= speed_difference
	scarab.acceleration += acc_difference
	scarab.ilimited_speed = true
	
	if scarab.retreat_area.overlaps_body(player):
		scarab.change_state("retreating")
	else:
		scarab.change_state("chasing")
