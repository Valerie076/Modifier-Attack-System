class_name CategorySidebarPanel
extends SidebarPanel

@export var title: String = "Title"
@export var description: String = "Description"

@onready var title_text: RichTextLabel = $HBoxContainer/MarginContainer/VBoxContainer/TitleText
@onready var description_text: RichTextLabel = $HBoxContainer/MarginContainer/VBoxContainer/DescriptionText

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	title_text.text = title
	description_text.text = description

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
