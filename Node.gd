extends "res://ailments.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	var sin = get_random_sin()
	var randomAilment = get_random_ailment(sin)
	
	var cure = randomAilment.keys()[0]
	var ailment = randomAilment.values()[0]
	print("Sin: ", sin)
	print("Ailment: ", ailment)
	print("Cure: ", cure)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
