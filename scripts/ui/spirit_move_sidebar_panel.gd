class_name SpiritMoveSidebarPanel
extends SidebarPanel

@export var move: Move

@onready var _title_text: RichTextLabel = $HBoxContainer/VBoxContainer/TitleText
@onready var _description_text: RichTextLabel = $HBoxContainer/VBoxContainer/DescriptionText

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_title_text.text = move.move_name
	_description_text.text = "desc"
