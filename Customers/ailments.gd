extends Node2D
class_name Ailments

# Ailment format: { cureObject = [Symptom1, Symptom2, Symptom3] }

var prideAilments = [
	{ 'pride1' = ['Irritable', 'Compliments', 'Heavy Breathing'] },
	{ 'pride2' = ['Arm Pain', 'Sweaty', 'Dry Mouth'] },
	{ 'pride3' = ['Poor Vision', 'Paranoia', 'Bouncy'] }
]

var greedAilments = [
	{ 'greed1' = ['Sweaty', 'Paranoia', 'Arm Pain'] },
	{ 'greed2' = ['Irritable', 'Dry Mouth', 'Dulled Touch'] },
	{ 'greed3' = ['Dulled Taste', 'Paranoia', 'Compliments'] }
]

var wrathAilments = [
	{ 'wrath1' = ['Irritable', 'Bouncy', 'Hungry'] },
	{ 'wrath2' = ['Arm Pain', 'Dulled Touch', 'Heavy Breathing'] },
	{ 'wrath3' = ['Poor Vision', 'Leg Pain', 'Paranoia'] }
]

var envyAilments = [
	{ 'envy1' = ['Poor Vision', 'Paranoia', 'Headache'] },
	{ 'envy2' = ['Dry Mouth', 'Irritable', 'Bouncy'] },
	{ 'envy3' = ['Dulled Taste', 'Heavy Breathing', 'Hungry'] }
]

var lustAilments = [
	{ 'lust1' = ['Sweaty', 'Dry Mouth', 'Smoke Smell'] },
	{ 'lust2' = ['Heavy Breathing', 'Irritable', 'Dulled Taste'] },
	{ 'lust3' = ['Irritable', 'Headache', 'Compliments'] }
]

var gluttonyAilments = [
	{ 'gluttony1' = ['Hungry', 'Heavy Breathing', 'Dulled Taste'] },
	{ 'gluttony2' = ['Smoke Smell', 'Narcolepsy', 'Sweaty'] },
	{ 'gluttony3' = ['Leg Pain', 'Dry Mouth', 'Bouncy'] }
]

var slothAilments = [
	{ 'sloth1' = ['Narcolepsy', 'Leg Pain', 'Smoke Smell'] },
	{ 'sloth2' = ['Poor Vision', 'Headache', 'Heavy Breathing'] },
	{ 'sloth3' = ['Narcolepsy', 'Dulled Touch', 'Hungry'] }
]

func get_random_sin():
	var sin = randi() % 7
	match sin:
		0:
			return ['Pride', 0]
		1:
			return ['Greed', 1]
		2:
			return ['Wrath', 2]
		3:
			return ['Envy', 3]
		4:
			return ['Lust', 4]
		5:
			return ['Gluttony', 5]
		6:
			return ['Sloth', 6]

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
