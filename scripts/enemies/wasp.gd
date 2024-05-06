extends Enemy

@onready var sprite = $AnimatedSprite2D

func move(delta):
	if position.distance_to(player.position) < PLAYER_DISTANCE:
		velocity = Vector2(0.0, 0.0)
		return
	
	var direction = position.direction_to(player.position)
	
	velocity.x += direction.x * delta * ACCELERATION
	velocity.y += direction.y * delta * ACCELERATION
	
	if velocity.length() > SPEED and not knockback_staggered:
		velocity = velocity.limit_length(SPEED)
	
	sprite.flip_h = player.position.x < position.x
