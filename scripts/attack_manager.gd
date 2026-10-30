class_name AttackManager
extends Node2D

enum AttackStage {
	INTRO,
	MODIFIERS,
	SPIRIT_CATEGORY,
	SPIRIT,
	ATTACK,
	BRIDGE
}

signal MelodySelected

## The staff to watch for inputs.
@export var play_staff: PlayStaff
@export var selection_menu: SelectionMenu
@export var current_stage: AttackStage = AttackStage.INTRO

var cummulative_score: float = 0.0

func _ready() -> void:
	play_staff.Finished.connect(_on_music_finished)
	# TODO
	# temporarily ignore intro
	
	# TODO modifiers
	current_stage = AttackStage.MODIFIERS
	
	current_stage = AttackStage.SPIRIT_CATEGORY

func _on_music_finished() -> void:
	#print("FINISHED")
	
	#var scores: Dictionary[float, SidebarPanel] = {}
	var best_score: float = 0.0
	var best_score_element: SidebarPanel
		
	for element in selection_menu.elements:
		var score = calculate_melody_score(element.staff.melody)
		#scores[score] = element
		
		if score > best_score:
			best_score = score
			best_score_element = element
	
	print("BEST:")
	print(best_score)
	#print(best_score_element._title_text.text)
	
	if best_score > 3500.0:
		cummulative_score += best_score
		MelodySelected.emit(best_score_element, cummulative_score / 100)

func calculate_melody_score(melody: Melody) -> float:
	var score: float = 0.0
	for target_note in melody.notes:
		for played_note in play_staff.melody.notes:
			# Calculate beat distance to each note
			var dist: float = absf(target_note.beat - played_note.beat)
			score += 500 - dist # Unscaled Linear TODO make exponential decay
			
			var pitch_diff: int = abs(target_note.pitch - played_note.pitch)
			score += 500 - (pitch_diff * 100) # Scaled Linear
	
	return score / len(melody.notes)
