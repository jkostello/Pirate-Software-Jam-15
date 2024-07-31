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
var cure

# Called when the node enters the scene tree for the first time.
func _ready():
	var sin = get_random_sin()
	%Creature.frame = sin[1]
	sin = sin[0]
	var randomAilment = get_random_ailment(sin)
	
	cure = randomAilment.keys()[0]
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
	
	
	$Customer.frame = randi_range(0,$Customer.sprite_frames.get_frame_count('default') - 1)
	Autoload.customer_info.emit(behavior_symptom, pain_symptom, sense_symptom)
	print("Sin: ", sin)
	print("Body symptom: ", body_symptom)
	print("Cure: ", cure)
	
	
	if body_symptom == 'Bouncy':
		$AnimationPlayer.speed_scale = 2.1
	
	
	$AnimationPlayer.play("Enter")


func intro():
	$Textbox.visible = true
	if intro_symptom:
		Autoload.display_symptom.emit(intro_symptom)
	else:
		$Textbox.add_text('Hi, I was told you can help me?')


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Enter":
		$AnimationPlayer.play("Idle")
		intro()
		
		match body_symptom:
			'Sweaty':
				$Customer/Sweat.visible = true
			'Heavy Breathing':
				$Customer/Breath.visible = true
