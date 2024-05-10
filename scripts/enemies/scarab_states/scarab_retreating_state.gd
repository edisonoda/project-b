extends ScarabChasingState

class_name ScarabRetreatingState

func _ready():
	sprite.play_backwards("walking")
	scarab.danger_zone.monitoring = false
	
	scarab.retreat_area.body_exited.connect(chase)

func move(delta: float):
	var direction = player.position.direction_to(scarab.position)
	
	scarab.velocity.x += direction.x * delta * scarab.acceleration
	scarab.velocity.y += direction.y * delta * scarab.acceleration
	
	if scarab.velocity.length() > scarab.speed and not scarab.ilimited_speed:
		scarab.velocity = scarab.velocity.limit_length(scarab.speed)

func chase(_body: Node2D):
	scarab.retreat_area.body_exited.disconnect(chase)
	scarab.change_state("chasing")
