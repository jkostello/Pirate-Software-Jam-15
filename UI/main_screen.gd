extends Node

var viewing_shop := true
var book_open := false
var strikes := 0
var day := 0 #goes to 5
var sinnersHelped := 0
@export var dailyCount = [0, 3, 4, 5, 7, 9]
signal fadeOutFinish

func _ready():
	day = 1
	generate_customer()
	Autoload.glass_visible.connect(glassvisible)
	%VisibleTimer.max_value = %CustomerTimer.wait_time
	


func _process(delta):
	%VisibleTimer.value = %CustomerTimer.time_left


func glassvisible(truefalse):
	%MagnifyingGlass.visible = truefalse

func generate_customer():
	
	# Delete current customer
	for customer in get_tree().get_nodes_in_group('customers'):
		customer.queue_free()
	
	#check if all sinners have been helped for the day
	sinnersHelped += 1
	print(sinnersHelped)
	print(dailyCount[day])
	if sinnersHelped > dailyCount[day]:
		passDay()
		await fadeOutFinish
	
	# Generate new customer
	var customer_scene = load('res://Customers/customer.tscn')
	var customer = customer_scene.instantiate()
	%Shop.add_child(customer)
	customer.add_to_group('customers')


func failed():
	strikes += 1
	if strikes >= 3:
		pass

func passDay():
	%MouseBlocker.visible = true
	%CustomerTimer.stop()
	sinnersHelped = 0
	%BlackScreen.self_modulate.a = 0
	%DayLabel.self_modulate.a = 0
	day += 1
	if day > 5:
		%DayLabel.text = "i hope you die.."
		fadeOut()
	else:
		%DayLabel.text = ("Day " + str(day))
		fadeOut()
		fadeIn()
	
func fadeOut():
	while %BlackScreen.self_modulate.a < 1:
		%BlackScreen.self_modulate.a += 0.01
		%DayLabel.self_modulate.a += 0.01
		await get_tree().create_timer(0.01).timeout

func fadeIn():
	await get_tree().create_timer(3).timeout
	while %BlackScreen.self_modulate.a > 0:
		%BlackScreen.self_modulate.a -= 0.01
		%DayLabel.self_modulate.a -= 0.01
		await get_tree().create_timer(0.01).timeout
	%MouseBlocker.visible = false
	%CustomerTimer.start()
	fadeOutFinish.emit()

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
		$Ritual/BookOpen.visible =  book_open
		$Ritual/BookClosed.visible = not book_open
		%Book._on_button_pressed()
		
