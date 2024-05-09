extends Node2D

class_name ScarabState

var speed_difference: float
var acc_difference: float
var attacking_time: float

var scarab: Scarab
var player: Player
var sprite: AnimatedSprite2D

func setup(s: Scarab, p: Player, a_sprite: AnimatedSprite2D):
	self.scarab = s
	self.player = p
	self.sprite = a_sprite
	
	speed_difference = s.speed_difference
	acc_difference = s.acceleration_difference
	attacking_time = s.attacking_time

func move(delta):
	if scarab.health <= 0 or scarab.position.distance_to(player.position) < scarab.player_distance:
		scarab.velocity = Vector2(0.0, 0.0)
		return
	
	var direction = scarab.position.direction_to(player.position)
	
	scarab.velocity.x += direction.x * delta * scarab.acceleration
	scarab.velocity.y += direction.y * delta * scarab.acceleration
	
	if scarab.velocity.length() > scarab.speed and not scarab.ilimited_speed:
		scarab.velocity = scarab.velocity.limit_length(scarab.speed)
