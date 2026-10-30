class_name SpiritSidebarPanel
extends SidebarPanel

@export var spirit: Spirit

@onready var _title_text: RichTextLabel = $HBoxContainer/VBoxContainer/TitleText
@onready var _description_text: RichTextLabel = $HBoxContainer/VBoxContainer/DescriptionText

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_title_text.text = spirit.spirit_name
	_description_text.text = "desc"
