extends Node

signal screen_shaked(trauma: float, power: float, decay: float)
signal canvas_modulated(color: Color, absolute: bool)
signal restored_canvas_module

func shake_screen(trauma: float, power: float, decay: float):
	screen_shaked.emit(trauma, power, decay)

func modulate_canvas(color: Color, absolute: bool = true):
	canvas_modulated.emit(color, absolute)

func restore_canvas_module():
	restored_canvas_module.emit()
