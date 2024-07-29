extends Node

var viewing_shop := true
var book_open := false


func _ready():
	generate_customer()

func generate_customer():
	# Delete current customer
	for customer in get_tree().get_nodes_in_group('customers'):
		customer.queue_free()

	# Generate new customer
	var customer_scene = load('res://Customers/customer.tscn')
	var customer = customer_scene.instantiate()
	%Shop.add_child(customer)
	customer.add_to_group('customers')

func _on_switch_pressed():
	if $AnimationPlayer.is_playing():
		return
	
	if viewing_shop:
		$AnimationPlayer.play("ToRitual")
	else:
		$AnimationPlayer.play("ToShop")
	viewing_shop = not viewing_shop


func _on_temp_generator_pressed():
	generate_customer()

func _on_customer_timer_timeout():
	generate_customer()


func _on_bookbutton_pressed():
	if not %Book/AnimationPlayer.is_playing():
		book_open = not book_open
		%BookOpen.visible = book_open
		%BookClosed.visible = not book_open
		%Book._on_button_pressed()
		
