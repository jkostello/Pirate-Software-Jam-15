extends Node2D
class_name RitualCircle

@export var identifier := ""

var base_ingredient : PackedScene = preload("res://Ingredients/base_ingredient.tscn")
var ingredients := {}

# Triggers when dust is sprinkled
# TODO: This should lock the ingredients, play an animation, clear everything, then make the item
func complete_ritual(dust_id : String):
	var points := $IngredientPoints.get_children()
	
	var ritual_array := [identifier, dust_id]
	for p in points:
		if ingredients.has(p):
			ritual_array.append(ingredients[p].identifier)
	
	
	var new_item_id : String
	match ritual_array:
		# Format: ["circle", "dust", "ingredient1", "ingredient2"...]
		["Example", "ingredient1", "2", "3"]:
			new_item_id = "example"
		["Triangle1", "golddust", "Peacock", "Eyes", "Feathers"]:
			new_item_id = "pride1"
		["Pentagram1", "golddust", "Moss", "Teeth", "Claws", "Beetle", "Eyes"]:
			new_item_id = "pride2"
		["Hexagram", "golddust", "Peacock", "Eyes", "Feathers", "Claws", "Rose", "Teeth"]:
			new_item_id = "pride3"
		["Triangle2", "silverdust", "Rose", "Claws", "Moss"]:
			new_item_id = "lust1"
		["Pentagram2", "silverdust", "Rose", "Feathers", "Eyes", "Peacock", "Ash"]:
			new_item_id = "lust2"
		["Hexagram", "platdust", "Rose", "Teeth", "Rose", "Peacock", "Rose", "Ash"]:
			new_item_id = "lust3"
		["Triangle1", "platdust", "Claws", "Teeth", "Ash"]:
			new_item_id = "wrath1"
		["Pentagram3", "golddust", "Beetle", "Ash", "Snake", "Rose", "Feather"]:
			new_item_id = "wrath2"
		["Hexagram", "golddust", "Claws", "Eyes", "Teeth", "Ash", "Snake", "Feather"]:
			new_item_id = "wrath3"
		["Triangle2", "platdust", "Snake", "Eyes", "Peacock"]:
			new_item_id = "envy1"
		["Pentagram4", "golddust", "Snake", "Eyes", "Eyes", "Beetle", "Moss"]:
			new_item_id = "envy2"
		["Hexagram", "golddust", "Eyes", "Snake", "Eyes", "Peacock", "Eyes", "Teeth"]:
			new_item_id = "envy3"
		["Triangle2", "platdust", "Beetle", "Peacock", "Rose"]:
			new_item_id = "greed1"
		["Pentagram2", "golddust", "Beetle", "Teeth", "Beetle", "Beetle", "Feathers"]:
			new_item_id = "greed2"
		["Hexagram", "golddust", "Beetle", "Beetle", "Beetle", "Beetle", "Beetle", "Beetle"]:
			new_item_id = "greed3"
		["Triangle1", "silverdust", "Eyes", "Teeth", "Claws"]:
			new_item_id = "gluttony1"
		["Pentagram3", "silverdust", "Snake", "Teeth", "Claws", "Moss", "Beetle"]:
			new_item_id = "gluttony2"
		["Hexagram", "silverdust", "Teeth", "Teeth", "Teeth", "Claws", "Claws", "Snake"]:
			new_item_id = "gluttony3"
		["Triangle1", "platdust", "Moss", "Moss", "Moss"]:
			new_item_id = "sloth1"
		["Pentagram1", "platdust", "Moss", "Moss", "Moss", "Ash", "Rose"]:
			new_item_id = "sloth2"
		["Hexagram", "platdust", "Moss", "Rose", "Moss", "Teeth", "Moss", "Ash"]:
			new_item_id = "sloth3"
		_:
			new_item_id = 'Failure'
			print(ritual_array)
	
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
