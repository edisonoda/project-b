extends Enemy

@onready var sprite = $AnimatedSprite2D

func move(delta):
	if position.distance_to(player.position) < player_distance:
		velocity = Vector2(0.0, 0.0)
		return
	
	var direction = position.direction_to(player.position)
	
	velocity.x += direction.x * delta * acceleration
	velocity.y += direction.y * delta * acceleration
	
	if velocity.length() > speed and not knockback_staggered:
		velocity = velocity.limit_length(speed)
	
	sprite.flip_h = player.position.x < position.x
