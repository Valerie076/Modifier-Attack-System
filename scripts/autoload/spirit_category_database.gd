extends Node

const CATS_DIR = "res://resources/spirit_categories/"

var categories: Array[SpiritCategory] = []

## Load the cats into memory.
func load_spirits() -> void:
	var dir: DirAccess = DirAccess.open(CATS_DIR)
	for file in dir.get_files():
		print(file)
		if file.ends_with(".tres"):
			var cat = load(CATS_DIR + file)
			categories.append(cat)
