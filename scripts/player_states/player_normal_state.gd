extends PlayerState

class_name PlayerNormalState

func _ready():
	sprite.flip_h = get_global_mouse_position().x < player.position.x

func _process(_delta):
	if Input.is_action_pressed("Reload") and player.gun.check_reload():
		player.gun.reload()
	
	if Input.is_action_pressed("Shoot") and player.gun.check_shoot():
		shoot()
	
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
		player.gun_marker.scale.x *= -1

func shoot():
	var a_sprite: AnimatedSprite2D = player.gun_marker.get_node("AnimatedSprite2D")
	var light: PointLight2D = player.gun_marker.get_node("PointLight2D")
	
	light.enabled = true
	player.gun.shoot()
	
	var stop_shooting = func():
		a_sprite.play("not_shooting")
		light.enabled = false
	
	a_sprite.animation_finished.connect(stop_shooting)
	a_sprite.play("shooting")

func receive_damage(damage):
	player.health -= damage
	
	if player.health <= 0:
		player.change_state("dead")
		return
	
	player.change_state("damaged")
	player.damaged_timer.start()
