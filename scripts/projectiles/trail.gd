extends Line2D

class_name Trail

@export var max_length: int = 5
var queue: Array

func _process(_delta):
	queue.push_front(get_parent().position)
	
	if queue.size() > max_length:
		queue.pop_back()
	
	clear_points()
	
	for point in queue:
		add_point(point)
