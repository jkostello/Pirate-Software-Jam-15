extends Node2D

var empty_circle := preload("res://Circles/base_circle.tscn")
var bigram := preload("res://Circles/bigram.tscn")
var pentagram := preload("res://Circles/pentagram.tscn")


func _ready():
	Autoload.use_chalk.connect(use_chalk)


# Gets the ID of the chalk used and creates the appropriate circle
func use_chalk(type):
	$CirclePos.get_child(0).clear_circle()
	$CirclePos.get_child(0).queue_free()
	var to_draw : Node2D
	
	match type:
		"Empty":
			to_draw = empty_circle.instantiate()
		"Bigram":
			to_draw = bigram.instantiate()
		"Pentagram":
			to_draw = pentagram.instantiate()
		_:
			print("INVALID CHALK ID:   ", type)
	
	$CirclePos.add_child(to_draw)
	


func _on_reset_pressed():
	use_chalk("Empty")
