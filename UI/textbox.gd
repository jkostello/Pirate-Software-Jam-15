extends Control

const CHAR_READ_RATE := 0.04 # How fast text scrolls

const dialogues = {
	'' = ['I haven\'t had any problem like that recently.'],
	'Compliments' = ['Well well, a mighty fine looking alchemist!', 'You doing anything later today?', 'I can only hope your alchemy is as good as your looks.'],
	'Hungry' = ['You ever eat any of those ingredients?', 'Do you have anything to eat in the back there?', 'Make it quick, I\'m starving.'],
	'Dry Mouth' = ['Do you have anything to drink that won\'t kill me?', 'You got any water anywhere in there?', 'Hope you can make me a quick drink too, if you don\'t mind.'],
	'Irritable' = ['I don\'t know, how \'bout you shut up and cure me?', 'Not sure about me but everyone\'s become awful annoying.'],
	'Paranoia' = ['I\'ve been seeing them... everywhere... do you see them too?', 'You\'re not going to tell someone if there\'s something wrong with me, right?'],
	'Narcolepsy' = ['...zzz... oh sorry, did you say something?', 'People say I\'m falling asleep all the time, but I don\'t remember.'],
	'Tired' = ['I\'ve been awfully sleepy recently.'],
	'Arm Pain' = ['My arm\'s been killing me, making work real difficult.', 'My arm, I don\'t want an amputation but I might need one.'],
	'Headache' = ['My head\'s feeling like someone\'s crushing it.', 'I don\'t know what torture\'s like, but I imagine the way my head feels is very close.'],
	'Leg Pain' = ['Do you have a chair I can sit down in? My leg hurts quite bad.', 'My leg hurts a lot, luckily I don\'t work standing up.'],
	'Poor Vision' = ['I can\'t see as well lately...', 'I think I\'m going blind!'],
	'Dulled Taste' = ['Food doesn\'t taste nearly as good recently...', 'Now that you mention it, the tavern hasn\'t tasted nearly as good.'],
	'Dulled Touch' = ['I accidentally burnt myself yesterday and I didn\'t even feel it!'],
	'Smoke Smell' = ['I smell something burning, are you cooking something back there?'],
}

# Called when the node enters the scene tree for the first time.
func _ready():
	Autoload.display_symptom.connect(add_symptom)
	%Body.text = ''

func add_text(text):
	if !%Body.text:
		%Body.text += '-' + text
	else:
		%Body.append_text('\n-' + text)

func add_symptom(symptom):
	var symptom_dialogue = dialogues[symptom][randi() % len(dialogues[symptom])]
	add_text(symptom_dialogue)
