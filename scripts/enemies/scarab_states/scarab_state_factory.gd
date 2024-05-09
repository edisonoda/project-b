class_name ScarabStateFactory

var states

func _init():
	states = {
		"chasing": ScarabChasingState,
		"charging": ScarabChargingState,
		"attacking": ScarabAttackingState
	}
	
func get_state(state_name: String):
	if states.has(state_name):
		return states.get(state_name)
	else:
		printerr("No state ", state_name, " in scarab state factory!")
