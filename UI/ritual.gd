extends Node2D

var empty_circle := preload("res://Circles/base_circle.tscn")

var triangle1 := preload("res://Circles/triangle1.tscn")
var triangle2 := preload("res://Circles/triangle2.tscn")
var pentagram1 := preload("res://Circles/pentagram1.tscn")
var pentagram2 := preload("res://Circles/pentagram2.tscn")
var pentagram3 := preload("res://Circles/pentagram3.tscn")
var pentagram4 := preload("res://Circles/pentagram4.tscn")
var hexagram := preload("res://Circles/hexagram.tscn")

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
		"Triangle1":
			to_draw = triangle1.instantiate()
		"Triangle2":
			to_draw = triangle2.instantiate()
		"Pentagram1":
			to_draw = pentagram1.instantiate()
		"Pentagram2":
			to_draw = pentagram2.instantiate()
		"Pentagram3":
			to_draw = pentagram3.instantiate()
		"Pentagram4":
			to_draw = pentagram4.instantiate()
		"Hexagram":
			to_draw = hexagram.instantiate()
		_:
			print("INVALID CHALK ID:   ", type)
	
	$CirclePos.add_child(to_draw)
	


func _on_reset_pressed():
	use_chalk("Empty")
