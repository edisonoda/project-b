extends AnimatedSprite2D

class_name OneShotAnimation

func with_data(frames: SpriteFrames) -> OneShotAnimation:
	sprite_frames = frames
	animation_finished.connect(self_destroy)
	play()
	return self

func self_destroy():
	queue_free()
