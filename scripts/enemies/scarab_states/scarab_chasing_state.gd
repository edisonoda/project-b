extends ScarabState

class_name ScarabChasingState

const FRICTION = 5

func _ready():
	sprite.play("walking")
	scarab.danger_zone.monitoring = false
	
	scarab.charge_area.body_entered.connect(charge)

func _physics_process(delta):
	if scarab.velocity.length() < scarab.speed:
		return
	
	var velocity = Vector2(scarab.velocity.x * FRICTION * delta, scarab.velocity.y * FRICTION * delta)
	
	if abs(scarab.velocity.x) - abs(velocity.x) < 0:
		velocity.x = scarab.velocity.x
	if abs(scarab.velocity.y) - abs(velocity.y) < 0:
		velocity.y = scarab.velocity.y
	
	scarab.velocity -= velocity

func charge(_body: Node2D):
	scarab.charge_area.body_entered.disconnect(charge)
	scarab.change_state("charging")
