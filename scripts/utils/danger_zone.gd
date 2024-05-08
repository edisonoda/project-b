extends Area2D

const DAMAGE = 1

func _on_body_entered(body):
	if body.has_method("receive_damage"):
		body.receive_damage(DAMAGE)
