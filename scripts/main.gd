extends Node2D

const CATEGORY_SIDEBAR_PANEL = preload("res://scenes/ui/category_sidebar_panel.tscn")

@onready var selection_menu: SelectionMenu = $CanvasLayer/SelectionMenu

var spirit_categories := Globals.SpiritCategory.keys()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SpiritDatabase.load_spirits()
	var category_panels: Array[CategorySidebarPanel] = create_category_panels()
	# Because of the way GDScript handles Array typing, you cannot pass Array[CategorySidebarPanel] into 
	# populate_menu so we get around this by creating a Array[SidebarPanel] and assigning its elements
	var panels: Array[SidebarPanel] = []
	panels.assign(category_panels)
	print(panels[0].description)
	print(panels)
	populate_menu(panels)

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
func _process(delta: float) -> void:
	pass
