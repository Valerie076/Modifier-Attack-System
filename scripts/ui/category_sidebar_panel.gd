class_name CategorySidebarPanel
extends SidebarPanel

@export var spirit_category: SpiritCategory

@onready var _title_text: RichTextLabel = $HBoxContainer/VBoxContainer/TitleText
@onready var _description_text: RichTextLabel = $HBoxContainer/VBoxContainer/DescriptionText

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_title_text.text = spirit_category.category_name
	_description_text.text = "desc"
