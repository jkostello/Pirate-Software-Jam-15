extends Control

const CHAR_READ_RATE := 0.08 # How fast text scrolls

# Called when the node enters the scene tree for the first time.
func _ready():
	%Body.text = ''

func add_text(text):
	if !%Body.text:
		%Body.text += text
	else:
		%Body.text += '\n\n' + text
	show()
	
	# Typewriter text effect
	var tween = create_tween()
	tween.tween_property(%Body, 'visible_ratio', 1, len(text) * CHAR_READ_RATE)
