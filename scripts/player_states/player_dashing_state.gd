extends PlayerState

class_name PlayerDashingState

const FRICTION = 2.5

func _ready():
	if player.velocity.x > 0:
		sprite.flip_h = false
	else:
		sprite.flip_h = true

func _physics_process(delta):
	var velocity = Vector2(player.velocity.x * FRICTION * delta, player.velocity.y * FRICTION * delta)
	
	if abs(player.velocity.x) - abs(velocity.x) < 0:
		velocity.x = player.velocity.x
	
	if abs(player.velocity.y) - abs(velocity.y) < 0:
		velocity.y = player.velocity.y
	
	player.velocity -= velocity
	sprite.play("dashing")
