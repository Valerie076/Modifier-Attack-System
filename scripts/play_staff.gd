class_name PlayStaff
extends Staff

@onready var playhead: Line2D = $Playhead

const BPM = 250.0

func _ready() -> void:
	playhead.position.x = -width / 2
	playhead.position.y = line_spacing * 2
	draw_lines()

func _process(delta: float) -> void:
	playhead.position.x += BPM * delta
	
	if playhead.position.x >= width / 2:
		playhead.position.x = -width / 2
		clear_notes()
