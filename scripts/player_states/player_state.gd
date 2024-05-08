extends Node2D

class_name PlayerState

var player: Player
var sprite: AnimatedSprite2D
var game_manager: GameManager

func setup(p: Player, a_sprite: AnimatedSprite2D, gm: GameManager):
	self.player = p
	self.sprite = a_sprite
	self.game_manager = gm

func receive_damage(_damage):
	pass
