extends PlayerState

class_name PlayerNormalState

func _process(delta):
	if Input.is_action_just_pressed("Use Ability"):
		player.p_class.use_ability()

func receive_damage(damage):
	player.health -= damage
	
	if player.health <= 0:
		player.change_state("dead")
		return
	
	player.change_state("damaged")
	player.damaged_timer.start()
