extends Node2D

class_name PlayerState

var player: Player
var sprite: AnimatedSprite2D
var game_manager: GameManager

func setup(player: Player, sprite: AnimatedSprite2D, game_manager: GameManager):
	self.player = player
	self.sprite = sprite
	self.game_manager = game_manager

func _physics_process(delta):
	var direction = Input.get_vector("Walk Left", "Walk Right", "Walk Up", "Walk Down")
	if direction:
		player.velocity.x = direction.x * player.speed * delta
		player.velocity.y = direction.y * player.speed * delta
		
		sprite.play("walking")
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.speed * delta)
		player.velocity.y = move_toward(player.velocity.y, 0, player.speed * delta)
		sprite.play("idle")
	
	var mouse = get_global_mouse_position()
	if mouse.x > player.position.x:
		sprite.flip_h = false
	elif mouse.x < player.position.x:
		sprite.flip_h = true
	
func receive_damage(damage):
	pass
