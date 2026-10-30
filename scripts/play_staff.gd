class_name PlayStaff
extends Staff

signal Finished

@onready var playhead: Line2D = $Playhead
@onready var phantom_playhead: Line2D = $PhantomPlayhead

const BPM = 200.0

func _ready() -> void:
	super._ready()
	playhead.position.x = -width / 2
	playhead.position.y = line_spacing * 2
	
	phantom_playhead.position.x = -width * 1.5
	phantom_playhead.position.y = line_spacing * 2

func _process(delta: float) -> void:
	playhead.position.x += BPM * delta
	
	phantom_playhead.position.x += BPM * delta
	
	if phantom_playhead.position.x >= -width:
		#phantom_playhead.default_color.a = (phantom_playhead.position.x - (width / 4)) / (width / 2)
		phantom_playhead.default_color.a += .66 * delta
	
	if playhead.position.x >= width / 2:
		Finished.emit()
		playhead.position.x = -width / 2
		clear_notes()
		
		phantom_playhead.position.x = -width * 1.5
		phantom_playhead.default_color.a = 0.0
