extends PClass

@export var force_ratio: float = 0.05

var dashing_force

func _process(_delta):
	if not player.state is PlayerDashingState:
		return
	
	if player.velocity.length() < player.speed / 50:
		player.change_state("normal")

func player_updated():
	dashing_force = player.speed * force_ratio

func ability():
	player.change_state("dashing")
	
	var direction = Input.get_vector("Walk Left", "Walk Right", "Walk Up", "Walk Down")
	player.velocity = Vector2(dashing_force * direction.x, dashing_force * direction.y)

func ability_finished():
	player.change_state("normal")
