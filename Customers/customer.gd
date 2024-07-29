extends Ailments

# Symptom categories
const INTROS := ['Compliments', 'Hungry', 'Dry Mouth']
const BEHAVIORS := ['Irritable', 'Paranoia', 'Narcolepsy', 'Tired']
const PAINS := ['Arm Pain', 'Headache', 'Leg Pain']
const SENSES := ['Poor Vision', 'Dulled Taste', 'Dulled Touch', 'Smoke Smell']
const BODY := ['Sweaty', 'Bouncy', 'Heavy Breathing']

# Customer's symptoms
var intro_symptom := ''
var behavior_symptom := ''
var pain_symptom := ''
var sense_symptom := ''
var body_symptom := ''

# Called when the node enters the scene tree for the first time.
func _ready():
	var sin = get_random_sin()
	var randomAilment = get_random_ailment(sin)
	
	var cure = randomAilment.keys()[0]
	var ailment = randomAilment.values()[0]
	
	# Assign symptoms
	for symptom in ailment:
		if INTROS.has(symptom):
			intro_symptom = symptom
		elif BEHAVIORS.has(symptom):
			behavior_symptom = symptom
		elif PAINS.has(symptom):
			pain_symptom = symptom
		elif SENSES.has(symptom):
			sense_symptom = symptom
		else:
			body_symptom = symptom
	
	
	Autoload.customer_info.emit(behavior_symptom, pain_symptom, sense_symptom)
	print("Sin: ", sin)
	print("Body symptom: ", body_symptom)
	print("Cure: ", cure)
	intro()
	
func intro():
	if intro_symptom:
		Autoload.display_symptom.emit(intro_symptom)
	else:
		$Textbox.add_text('Hi, I was told you can help me?')
