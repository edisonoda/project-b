extends PlayerState

class_name PlayerNormalState

func _ready():
	sprite.flip_h = get_global_mouse_position().x < player.position.x

func _process(_delta):
	if Input.is_action_pressed("Reload"):
		player.gun.reload()
	
	if Input.is_action_pressed("Shoot"):
		player.gun.shoot()
		
	if Input.is_action_just_pressed("Use Ability"):
		player.p_class.use_ability()

func _physics_process(delta):
	check_walking(delta)
	check_player_orientation()

func check_walking(delta):
	var direction = Input.get_vector("Walk Left", "Walk Right", "Walk Up", "Walk Down")
	if direction:
		player.velocity.x = direction.x * player.speed * delta
		player.velocity.y = direction.y * player.speed * delta
		
		sprite.play("walking")
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.speed * delta)
		player.velocity.y = move_toward(player.velocity.y, 0, player.speed * delta)
		sprite.play("idle")

func check_player_orientation():
	var flipped = sprite.flip_h
	sprite.flip_h = get_global_mouse_position().x < player.position.x
	
	if flipped != sprite.flip_h:
		player.gun_marker.position.x *= -1

func receive_damage(damage):
	player.health -= damage
	
	if player.health <= 0:
		player.change_state("dead")
		return
	
	player.change_state("damaged")
	player.damaged_timer.start()
