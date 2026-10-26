class_name SelectionMenu
extends Control

@onready var selection_menu: SelectionMenu = $"."

@export var elements: Array[SidebarPanel] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for element in elements:
		add_child(element)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
