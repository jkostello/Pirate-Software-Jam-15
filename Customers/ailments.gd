extends Node2D
class_name Ailments

# Ailment format: { cureObject = [Symptom1, Symptom2, Symptom3] }

var prideAilments = [
	{ 'cure1' = ['Irritable', 'Compliments', 'Heavy Breathing'] },
	{ 'cure2' = ['Arm Pain', 'Sweaty', 'Dry Mouth'] },
	{ 'cure3' = ['Poor Vision', 'Paranoia', 'Bouncy'] }
]

var greedAilments = [
	{ 'cure1' = ['Sweaty', 'Paranoia', 'Arm Pain'] },
	{ 'cure2' = ['Hungry', 'Dry Mouth', 'Dulled Touch'] },
	{ 'cure3' = ['Dulled Taste', 'Paranoia', 'Compliments'] }
]

var wrathAilments = [
	{ 'cure1' = ['Irritable', 'Bouncy', 'Hungry'] },
	{ 'cure2' = ['Arm Pain', 'Dulled Touch', 'Heavy Breathing'] },
	{ 'cure3' = ['Poor Vision', 'Leg Pain', 'Paranoia'] }
]

var envyAilments = [
	{ 'cure1' = ['Poor Vision', 'Paranoia', 'Headache'] },
	{ 'cure2' = ['Dry Mouth', 'Irritable', 'Bouncy'] },
	{ 'cure3' = ['Dulled Taste', 'Heavy Breathing', 'Hungry'] }
]

var lustAilments = [
	{ 'cure1' = ['Sweaty', 'Dry Mouth', 'Smoke Smell'] },
	{ 'cure2' = ['Heavy Breathing', 'Irritable', 'Dulled Taste'] },
	{ 'cure3' = ['Irritable', 'Headache', 'Compliments'] }
]

var gluttonyAilments = [
	{ 'cure1' = ['Hungry', 'Heavy Breathing', 'Dulled Taste'] },
	{ 'cure2' = ['Smoke Smell', 'Narcolepsy', 'Sweaty'] },
	{ 'cure3' = ['Leg Pain', 'Dry Mouth', 'Bouncy'] }
]

var slothAilments = [
	{ 'cure1' = ['Narcolepsy', 'Leg Pain', 'Smoke Smell'] },
	{ 'cure2' = ['Poor Vision', 'Headache', 'Heavy Breathing'] },
	{ 'cure3' = ['Narcolepsy', 'Dulled Touch', 'Hungry'] }
]

func get_random_sin():
	var sin = randi() % 7
	match sin:
		0:
			return 'Pride'
		1:
			return 'Greed'
		2:
			return 'Wrath'
		3:
			return 'Envy'
		4:
			return 'Lust'
		5:
			return 'Gluttony'
		6:
			return 'Sloth'

func get_random_ailment(sin):
	var ailment : Dictionary
	
	match sin:
		'Pride':
			ailment = prideAilments[randi() % prideAilments.size()]
		'Greed':
			ailment = greedAilments[randi() % greedAilments.size()]
		'Wrath':
			ailment = wrathAilments[randi() % wrathAilments.size()]
		'Envy':
			ailment = envyAilments[randi() % envyAilments.size()]
		'Lust':
			ailment = lustAilments[randi() % lustAilments.size()]
		'Gluttony':
			ailment = gluttonyAilments[randi() % gluttonyAilments.size()]
		'Sloth':
			ailment = slothAilments[randi() % slothAilments.size()]
	
	return ailment
