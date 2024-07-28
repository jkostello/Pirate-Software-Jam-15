extends Node

func _ready():
	generate_customer()

func generate_customer():
	# Delete current customer
	for customer in get_tree().get_nodes_in_group('customers'):
		customer.queue_free()

	# Generate new customer
	var customer_scene = load('res://Customers/customer.tscn')
	var customer = customer_scene.instantiate()
	add_child(customer)
	customer.add_to_group('customers')
