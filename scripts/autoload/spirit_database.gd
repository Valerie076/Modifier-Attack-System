extends Node

const SPIRITS_DIR = "res://resources/spirits/"

var spirits: Array[Spirit] = []

## Load the spirits into memory.
func load_spirits() -> void:
	var dir: DirAccess = DirAccess.open(SPIRITS_DIR)
	for file in dir.get_files():
		if file.ends_with(".tres"):
			var spirit = load(SPIRITS_DIR + file)
			spirits.append(spirit)

## Return an array of spirits matching the specified category.
func get_spirits_by_category(category: Globals.SpiritCategory) -> Array[Spirit]:
	var cat_spirits: Array[Spirit] = []
	for spirit in spirits:
		if spirit.category == category:
			cat_spirits.append(spirit)
	return cat_spirits
