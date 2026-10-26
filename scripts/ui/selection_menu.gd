class_name SelectionMenu
extends Control

@onready var v_box_container: VBoxContainer = $VBoxContainer

@export var elements: Array[SidebarPanel] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update()

## Update the elements in the sidebar.
func update() -> void:
	for n in v_box_container.get_children():
		v_box_container.remove_child(n)
		n.queue_free()
	
	for element in elements:
		v_box_container.add_child(element)
		print(element.title)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
