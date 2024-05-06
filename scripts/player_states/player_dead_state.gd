extends PlayerState

class_name PlayerDeadState

func _ready():
	game_manager.game_over()

func _physics_process(delta):
	player.velocity.x = move_toward(player.velocity.x, 0, player.speed * delta)
	player.velocity.y = move_toward(player.velocity.y, 0, player.speed * delta)
	sprite.play("death")
