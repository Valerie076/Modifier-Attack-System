extends Node2D

const CATEGORY_SIDEBAR_PANEL = preload("res://scenes/ui/category_sidebar_panel.tscn")

@onready var selection_menu: SelectionMenu = $CanvasLayer/SelectionMenu
@onready var staff: Staff = $Staff
@onready var play_staff: PlayStaff = $PlayStaff

@onready var note_1: AudioStreamPlayer = $Note1
@onready var note_2: AudioStreamPlayer = $Note2
@onready var note_3: AudioStreamPlayer = $Note3
@onready var note_4: AudioStreamPlayer = $Note4
@onready var note_5: AudioStreamPlayer = $Note5

var spirit_categories := Globals.SpiritCategory.keys()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SpiritDatabase.load_spirits()
	var category_panels: Array[CategorySidebarPanel] = create_category_panels()
	# Because of the way GDScript handles Array typing, you cannot pass Array[CategorySidebarPanel] into 
	# populate_menu so we get around this by creating a Array[SidebarPanel] and assigning its elements
	var panels: Array[SidebarPanel] = []
	panels.assign(category_panels)
	populate_menu(panels)
	
	staff.add_melody(SpiritDatabase.spirits[0].moves[0].melody)

## Return CategorySidebarPanel objects for each spirit category
func create_category_panels() -> Array[CategorySidebarPanel]:
	var panels: Array[CategorySidebarPanel] = []
	for cat in spirit_categories:
		var panel = CATEGORY_SIDEBAR_PANEL.instantiate()
		panel.title = str(cat)
		panel.description = "This is an element!"
		panels.append(panel)
	
	return panels

func populate_menu(panels: Array[SidebarPanel]) -> void:
	selection_menu.elements = panels
	selection_menu.update()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var note_data: NoteData = NoteData.new()
	# Crazy math
	note_data.beat = 4 * (play_staff.playhead.position.x / play_staff.width) + 2.0
	note_data.duration = Globals.Duration.SIXTEENTH
	if Input.is_action_just_pressed("note_one"):
		note_data.pitch = Globals.Pitch.I
		note_1.play()
	if Input.is_action_just_pressed("note_two"):
		note_data.pitch = Globals.Pitch.II
		note_2.play()
	if Input.is_action_just_pressed("note_three"):
		note_data.pitch = Globals.Pitch.III
		note_3.play()
	if Input.is_action_just_pressed("note_four"):
		note_data.pitch = Globals.Pitch.IV
		note_4.play()
	if Input.is_action_just_pressed("note_five"):
		note_data.pitch = Globals.Pitch.V
		note_5.play()
	
	play_staff.add_note(note_data)
