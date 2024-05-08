extends Timer

class_name Repeater

var running: bool = false

func setup(ref_node: Node, time: float):
	one_shot = true
	wait_time = time
	timeout.connect(on_end)
	
	ref_node.add_child(self)

func restart(time_sec: float = -1.0):
	start(time_sec)
	running = true

func on_end():
	running = false
