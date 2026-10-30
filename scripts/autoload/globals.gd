extends Node

## Pitches on the pentatonic scale.
enum Pitch {
	REST = 0,
	I = 1,
	II = 2,
	III = 3,
	IV = 4,
	V = 5
}

enum Duration {
	REST = 0,
	WHOLE = 1,
	HALF = 2,
	TRIPLET = 3,
	QUARTER = 4,
	EIGTH = 8,
	SIXTEENTH = 16
}

var Colors: Dictionary[Pitch, Color] = {
	Pitch.I: Color.GREEN,
	Pitch.II: Color.RED,
	Pitch.III: Color.BLUE,
	Pitch.IV: Color.YELLOW,
	Pitch.V: Color.MEDIUM_PURPLE
}
