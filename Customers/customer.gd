extends Ailments

@onready var intros := ['Compliments', 'Hungry', 'Dry Mouth']
@onready var behaviors := ['Irritable', 'Paranoia', 'Narcolepsy', 'Tired']
@onready var pains := ['Arm Pain', 'Headache', 'Leg Pain']
@onready var senses := ['Poor Vision', 'Dulled Taste', 'Dulled Touch', 'Smoke Smell']
@onready var body := ['Sweaty', 'Bouncy', 'Heavy Breathing']

var intro_symptom = ''
var behavior_symptom = ''
var pain_symptom = ''
var sense_symptom = ''
var body_symptom = ''

# Called when the node enters the scene tree for the first time.
func _ready():
	var sin = get_random_sin()
	var randomAilment = get_random_ailment(sin)
	
	var cure = randomAilment.keys()[0]
	var ailment = randomAilment.values()[0]
	
	# Assign symptoms
	for symptom in ailment:
		if intros.has(symptom):
			intro_symptom = symptom
		elif behaviors.has(symptom):
			behavior_symptom = symptom
		elif pains.has(symptom):
			pain_symptom = symptom
		elif senses.has(symptom):
			sense_symptom = symptom
		else:
			body_symptom = symptom
	
	
	Autoload.customer_info.emit(behavior_symptom, pain_symptom, sense_symptom)
	print("Sin: ", sin)
	print("Intro symptom: ", intro_symptom)
	print("Body symptom: ", body_symptom)
	print("Cure: ", cure)
