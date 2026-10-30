extends Node2D

const CATEGORY_SIDEBAR_PANEL = preload("res://scenes/ui/category_sidebar_panel.tscn")
const SPIRIT_SIDEBAR_PANEL = preload("res://scenes/ui/spirit_sidebar_panel.tscn")
const SPIRIT_MOVE_SIDEBAR_PANEL = preload("res://scenes/ui/spirit_move_sidebar_panel.tscn")

@onready var selection_menu: SelectionMenu = $CanvasLayer/SelectionMenu
@onready var staff: Staff = $Staff
@onready var play_staff: PlayStaff = $PlayStaff
@onready var attack_manager: AttackManager = $AttackManager
@onready var damage_label: RichTextLabel = $CanvasLayer/DamageLabel

@onready var note_1: AudioStreamPlayer = $NotesSFX/Note1
@onready var note_2: AudioStreamPlayer = $NotesSFX/Note2
@onready var note_3: AudioStreamPlayer = $NotesSFX/Note3
@onready var note_4: AudioStreamPlayer = $NotesSFX/Note4
@onready var note_5: AudioStreamPlayer = $NotesSFX/Note5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	attack_manager.MelodySelected.connect(_on_melody_selected)
	
	selection_menu.header.text = "Spirit Categories"
	
	SpiritDatabase.load_spirits()
	SpiritCategoryDatabase.load_spirits()
	var category_panels: Array[CategorySidebarPanel] = create_category_panels()
	# Because of the way GDScript handles Array typing, you cannot pass Array[CategorySidebarPanel] into 
	# populate_menu so we get around this by creating a Array[SidebarPanel] and assigning its elements
	var panels: Array[SidebarPanel] = []
	panels.assign(category_panels)
	populate_menu(panels)
	
	staff.melody = SpiritDatabase.spirits[0].moves[0].melody # TODO - REMOVE

## Return CategorySidebarPanel objects for each spirit category
func create_category_panels() -> Array[CategorySidebarPanel]:
	var panels: Array[CategorySidebarPanel] = []
	for cat in SpiritCategoryDatabase.categories:
		var panel: CategorySidebarPanel = CATEGORY_SIDEBAR_PANEL.instantiate()
		panel.spirit_category = cat
		panels.append(panel)
	
	return panels

## Return SpiritSidebarPanel objects for each spirit category
func create_spirit_panels(spirit_category: SpiritCategory) -> Array[SpiritSidebarPanel]:
	var panels: Array[SpiritSidebarPanel] = []
	for spirit in SpiritDatabase.get_spirits_by_category(spirit_category):
		var panel: SpiritSidebarPanel = SPIRIT_SIDEBAR_PANEL.instantiate()
		panel.spirit = spirit
		panels.append(panel)
	
	return panels

## Return SpiritMoveSidebarPanel objects for each spirit
func create_move_panels(spirit: Spirit) -> Array[SpiritMoveSidebarPanel]:
	var panels: Array[SpiritMoveSidebarPanel] = []
	for move in spirit.moves:
		var panel: SpiritMoveSidebarPanel = SPIRIT_MOVE_SIDEBAR_PANEL.instantiate()
		panel.move = move
		panels.append(panel)
	
	return panels

func populate_menu(panels: Array[SidebarPanel]) -> void:
	selection_menu.elements = panels
	selection_menu.update()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var note_data: NoteData = NoteData.new()
	var action_pressed: bool = false
	# Crazy math
	note_data.beat = 4 * (play_staff.playhead.position.x / play_staff.width) + 2.0
	note_data.duration = Globals.Duration.SIXTEENTH
	if Input.is_action_just_pressed("note_one"):
		note_data.pitch = Globals.Pitch.I
		note_1.play()
		action_pressed = true
	if Input.is_action_just_pressed("note_two"):
		note_data.pitch = Globals.Pitch.II
		note_2.play()
		action_pressed = true
	if Input.is_action_just_pressed("note_three"):
		note_data.pitch = Globals.Pitch.III
		note_3.play()
		action_pressed = true
	if Input.is_action_just_pressed("note_four"):
		note_data.pitch = Globals.Pitch.IV
		note_4.play()
		action_pressed = true
	if Input.is_action_just_pressed("note_five"):
		note_data.pitch = Globals.Pitch.V
		note_5.play()
		action_pressed = true
		
	if action_pressed:
		var new_melody: Melody = Melody.new()
		var new_notes: Array[NoteData] = play_staff.melody.notes
		new_notes.append(note_data)
		new_melody.notes = new_notes
		play_staff.melody = new_melody
		#play_staff.add_note(note_data)

func _on_melody_selected(selection: SidebarPanel, score: float) -> void:
	damage_label.text = "DAMAGE: " + str(int(roundf(score)))
	if is_instance_of(selection, CategorySidebarPanel):
		selection_menu.header.text = selection.spirit_category.category_name
		
		var spirit_panels: Array[SpiritSidebarPanel] = create_spirit_panels(selection.spirit_category)
		var panels: Array[SidebarPanel] = []
		panels.assign(spirit_panels)
		populate_menu(panels)

	elif is_instance_of(selection, SpiritSidebarPanel):
		selection_menu.header.text = selection.spirit.spirit_name
		
		var move_panels: Array[SpiritMoveSidebarPanel] = create_move_panels(selection.spirit)
		var panels: Array[SidebarPanel] = []
		panels.assign(move_panels)
		populate_menu(panels)

	elif is_instance_of(selection, SpiritMoveSidebarPanel):
		selection_menu.header.text = "Spirit Categories"
		
		var category_panels: Array[CategorySidebarPanel] = create_category_panels()
		var panels: Array[SidebarPanel] = []
		panels.assign(category_panels)
		populate_menu(panels)
