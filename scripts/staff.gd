class_name Staff
extends Node2D

const NOTE = preload("res://scenes/note.tscn")

@onready var notes: Node2D = $Notes

@onready var lines: Node2D = $Lines
@onready var f_line: Line2D = $Lines/FLine
@onready var d_line: Line2D = $Lines/DLine
@onready var b_line: Line2D = $Lines/BLine
@onready var g_line: Line2D = $Lines/GLine
@onready var e_line: Line2D = $Lines/ELine
@onready var left_line: Line2D = $Lines/LeftLine
@onready var right_line: Line2D = $Lines/RightLine

@export var line_spacing: float = 24.0
@export var width: float = 600.0
@export var line_width: float = 2.0
## Whether or not to draw thinner lines at each fourth.
@export var draw_quarters: bool = true
@export var melody: Melody = Melody.new():
	set(new_melody):
		melody = new_melody
		if new_melody.notes:
			for note_data in new_melody.notes:
				add_note(note_data)

func _ready() -> void:
	draw_lines()

func draw_lines() -> void:
	var left: float = -width / 2
	
	var h_lines: Array[Line2D] = [f_line, d_line, b_line, g_line, e_line]
	
	for i in range(5):
		var y: float = i * line_spacing
		
		h_lines[i].width = line_width
		
		h_lines[i].add_point(Vector2(left, y))
		h_lines[i].add_point(Vector2(-left, y))
	
	left_line.width = line_width
	left_line.add_point(Vector2(-width / 2, 0))
	left_line.add_point(Vector2(-width / 2, 4 * line_spacing))
	
	right_line.width = line_width
	right_line.add_point(Vector2(width / 2, 0))
	right_line.add_point(Vector2(width / 2, 4 * line_spacing))
	
	if draw_quarters:
		for i in range(1, 4):
			var line: Line2D = Line2D.new()
			
			#if line_width <= 1.0:
			line.default_color = Color(0.486, 0.486, 0.486, 1.0)
			line.width = line_width / 2.0 if line_width > 1.0 else line_width
			line.add_point(Vector2(-width / 2 + (width / 4) * i, 0))
			line.add_point(Vector2(-width / 2 + (width / 4) * i, 4 * line_spacing))
			
			lines.add_child(line)

func add_melody(m: Melody) -> void:
	self.melody = m

func add_note(note_data: NoteData) -> void:
	if note_data.pitch == Globals.Duration.REST or note_data.pitch == Globals.Pitch.REST:
		return
	
	var note: Note = NOTE.instantiate()
	
	# Position
	note.position.x = width * (0.25 * note_data.beat - 0.5)
	note.position.y = (5 - note_data.pitch) * line_spacing
	
	notes.add_child(note)
	
	note.sprite_scaler.scale.x = line_width / 2.0
	note.sprite_scaler.scale.y = line_width / 2.0
	note.note_length.width = line_width * 5.0
	
	# Color
	note.sprite.modulate = Globals.Colors[note_data.pitch]
	
	# Trail
	#var gradient = Gradient.new()
	#gradient.remove_point(0)
	#gradient.remove_point(1)
	#gradient.add_point(0.0, Globals.Colors[note_data.pitch])
	#gradient.add_point(1.0, Color(1.0, 1.0, 1.0, 0.533))
	#note.note_length.gradient = gradient
	note.note_length.default_color = Globals.Colors[note_data.pitch]
	
	note.note_length.add_point(Vector2.ZERO)
	note.note_length.add_point(Vector2((1. / note_data.duration) * width, 0))

func clear_notes() -> void:
	for note in notes.get_children():
		note.queue_free()
	melody = Melody.new()
