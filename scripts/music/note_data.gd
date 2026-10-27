class_name NoteData
extends Resource

## 0.0 = song start, 1.0 = one quarter note later
@export var beat: float
## The pitch of the note, which corresponds to one of the five inputs.
@export var pitch: Globals.Pitch
## Duration of note.
@export var duration: Globals.Duration
