class_name NoteData
extends Resource

## The pitch of the note, which corresponds to one of the five inputs.
@export var pitch: Globals.Pitch
## 0.0 = song start, 1.0 = one quarter note later
@export var beats: float
## Duration of note.
@export var duration: Globals.Duration
