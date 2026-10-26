class_name CategorySidebarPanel
extends SidebarPanel

@export var title: String = "Title"
@export var description: String = "Description"

@onready var _title_text: RichTextLabel = $HBoxContainer/VBoxContainer/TitleText
@onready var _description_text: RichTextLabel = $HBoxContainer/VBoxContainer/DescriptionText

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_title_text.text = title
	_description_text.text = description

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
