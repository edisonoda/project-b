class_name PlayerStateFactory

var states

func _init():
	states = {
		"normal": PlayerNormalState,
		"damaged": PlayerDamagedState,
		"dashing": PlayerDashingState,
		"dead": PlayerDeadState
	}
	
func get_state(state_name: String):
	if states.has(state_name):
		return states.get(state_name)
	else:
		printerr("No state ", state_name, " in player state factory!")
