extends Line2D

class_name Lightning

signal finished

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var divider: float = 10
@export var max_sway: float = 10
@export var sway_divider: float = 40

var points_lerp: Array = []
var sway_value: float

func with_data(start: Vector2, end: Vector2) -> Lightning:
	var from_to = end - start
	add_point(start)
	add_point(end)
	segmentize(from_to, start)
	sway(Vector2(from_to.y, -from_to.x).normalized())
	return self

func segmentize(from_to: Vector2, start: Vector2):
	var distance: float = from_to.length()
	print(distance)
	var segment_count: int = distance / divider
	
	sway_value = distance / sway_divider
	sway_value = clamp(sway_value, 0, max_sway)
	
	points_lerp.clear()
	for point in range(0, segment_count):
		points_lerp.append(randf())
	points_lerp.sort()
	
	var point_index: int = 1
	for offset in points_lerp:
		add_point(start + offset * from_to, point_index)
		++point_index

func sway(normal: Vector2):
	var offset
	var point_count: int = get_point_count() - 1
	for point in point_count:
		if point != 0 and point != point_count:
			offset = (get_point_position(point) + get_point_position(point - 1)) / 2
			offset += normal * randf_range(-sway_value, sway_value)
			set_point_position(point, offset)

func strike():
	await get_tree().process_frame
	animation_player.play("fade")

func finish():
	finished.emit()
	queue_free()
