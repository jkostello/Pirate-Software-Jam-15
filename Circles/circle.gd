extends Node2D
class_name RitualCircle

@export var identifier := ""

var base_ingredient : PackedScene = preload("res://Ingredients/base_ingredient.tscn")
var ingredients := {}

# Triggers when dust is sprinkled
# TODO: This should lock the ingredients, play an animation, clear everything, then make the item
func complete_ritual(dust_id : String):
	var points := $IngredientPoints.get_children()
	
	var ritual_array := [identifier]
	for p in points:
		if ingredients.has(p):
			ritual_array.append(ingredients[p].identifier)
	
	
	var new_item_id : String
	match ritual_array:
		["Example", "ingredint1", "2", "3"]:
			pass
		["Triangle1"]:
			pass
		["Triangle2"]:
			pass
		["Pentagram1"]:
			pass
		["Pentagram2"]:
			pass
		["Pentagram3"]:
			pass
		["Pentagram4"]:
			pass
		["Hexagram"]:
			pass
		_:
			new_item_id = 'Failure'
	
	clear_circle()
	
	var output : Ingredient = base_ingredient.instantiate() # Only for testing, needs to be customized
	output.identifier = new_item_id
	
	get_parent().add_child(output)
	output.current_point = $Center


# Empties all components but does not reset the circle
func clear_circle():
	for i in ingredients:
		ingredients[i].fail_placement()
	ingredients.clear()
