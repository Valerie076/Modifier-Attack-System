class_name SelectionMenu
extends Control

@onready var panel_container: VBoxContainer = $VBoxContainer/PanelContainer
@onready var header: RichTextLabel = $VBoxContainer/Header

@export var elements: Array[SidebarPanel] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update()

## Update the elements in the sidebar.
func update() -> void:
	for n in panel_container.get_children():
		panel_container.remove_child(n)
		n.queue_free()
	
	for element in elements:
		panel_container.add_child(element)
		if is_instance_of(element, CategorySidebarPanel):
			element.staff.melody = element.spirit_category.melody
		elif is_instance_of(element, SpiritSidebarPanel):
			element.staff.add_melody(element.spirit.melody)
		elif is_instance_of(element, SpiritMoveSidebarPanel):
			element.staff.melody = element.move.melody
