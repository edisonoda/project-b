@tool
extends Node2D

class_name Circle

@export var radius: float = 120.0:
	set(v):
		radius = v
		queue_redraw()

@export var thickness: float = 20.0:
	set(v):
		thickness = v
		queue_redraw()

@export var color := Color(0.5, 0.5, 0.5, 1.0):
	set(v):
		color = v
		queue_redraw()

@export var nb_points: int = 32

func _draw() -> void:
	draw_ring(Vector2.ZERO, radius, radius-thickness, 0.0, TAU)

func _process(_delta: float) -> void:
	queue_redraw()

func draw_ring(center: Vector2, radius1: float, radius2: float,\
		angle_from: float, angle_to: float) -> void:
	var points_arc := PackedVector2Array()
	var colors := PackedColorArray([color])
	var a: float = angle_from - (PI / 2.0)
	var b: float = (angle_to - angle_from) / float(nb_points)
	for i in range(nb_points + 1):
		var angle_point: float = a + float(i) * b
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius1)
	for i in range(nb_points, -1, -1):
		var angle_point: float = a + float(i) * b
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius2)
	draw_polygon(points_arc, colors)
