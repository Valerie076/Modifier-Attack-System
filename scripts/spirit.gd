class_name Spirit
extends Resource

@export var spirit_name: String
## The category the spirit belongs to.
@export var category: SpiritCategory
## The short melody used to select this spirit.
@export var melody: Melody
## The attacks the spirit can perform.
@export var moves: Array[Move] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
