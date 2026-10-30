extends Node2D

const LINE_SPACING: float = 24.0
const WIDTH: float = 600.0

func _draw() -> void:
	for i in range(5):
		var y: float = i * LINE_SPACING
		draw_line(Vector2(-WIDTH / 2, y), Vector2(WIDTH / 2, y), Color.WHITE, 2.0)
	
	draw_line(Vector2(-WIDTH / 2, 0), Vector2(-WIDTH / 2, 4 * LINE_SPACING), Color.WHITE, 2.0)
	draw_line(Vector2(WIDTH / 2, 0), Vector2(WIDTH / 2, 4 * LINE_SPACING), Color.WHITE, 2.0)
