extends Node

var viewing_shop := true
var book_open := false
var strikes := 0
var day := 0 #goes to 5
var sinnersHelped := 0
@export var dailyCount = [0, 3, 4, 5, 7, 9]
@export var dayTimer = [0, 80, 70, 60, 55, 50]
signal fadeOutFinish

var title_screen : PackedScene = load("res://UI/title_screen.tscn")

func _ready():
	day = 1
	generate_customer()
	Autoload.glass_visible.connect(glassvisible)
	#%VisibleTimer.max_value = %CustomerTimer.wait_time
	$CanvasLayer/Switch.position = Vector2(0,989)
	


func _process(_delta):
	#%VisibleTimer.value = %CustomerTimer.time_left
	%Hourglass.frame = 10 - int((%CustomerTimer.time_left + 0.99) / %CustomerTimer.wait_time * 100) / 10
	loopMusic()


func glassvisible(truefalse):
	$MagnifyingGlassPickup.play()
	%MagnifyingGlass.visible = truefalse

func generate_customer():
	
	# Delete current customer
	for customer in get_tree().get_nodes_in_group('customers'):
		customer.queue_free()
	
	if strikes >= 3:
		return
	
	#check if all sinners have been helped for the day
	sinnersHelped += 1
	#print(sinnersHelped)
	#print(dailyCount[day])
	if sinnersHelped > dailyCount[day]:
		passDay()
		await fadeOutFinish
	
	# Generate new customer
	var customer_scene = load('res://Customers/customer.tscn')
	var customer = customer_scene.instantiate()
	%Shop.add_child(customer)
	customer.add_to_group('customers')
	
	$Success.play()


func failed():
	strikes += 1
	var failed_torch = $Shop/Lives.get_child(strikes-1)
	failed_torch.get_child(0).set_frame(1)
	$Failure.play()
	if strikes >= 3:
		%CustomerTimer.stop()
		fadeOut("You have failed to cure too many patients\nWord of your witchcraft has been spread\nYou will now be burned at the stake")

func passDay():
	%MouseBlocker.visible = true
	%CustomerTimer.stop()
	sinnersHelped = 0
	%BlackScreen.self_modulate.a = 0
	%DayLabel.self_modulate.a = 0
	day += 1
	if day > 5:
		fadeOut("Congratulations!\nYou managed to survive all 5 days!")
	else:
		%CustomerTimer.wait_time = dayTimer[day]
		print(%CustomerTimer.wait_time)
		fadeOut(("Day " + str(day)))
		fadeIn()
	
func fadeOut(text):
	%DayLabel.text = text
	while %BlackScreen.self_modulate.a < 1:
		%BlackScreen.self_modulate.a += 0.01
		%DayLabel.self_modulate.a += 0.01
		await get_tree().create_timer(0.01).timeout
	if strikes >= 3 or day > 5:
		await get_tree().create_timer(3).timeout
		get_tree().change_scene_to_packed(title_screen)

func fadeIn():
	await get_tree().create_timer(3).timeout
	while %BlackScreen.self_modulate.a > 0:
		%BlackScreen.self_modulate.a -= 0.01
		%DayLabel.self_modulate.a -= 0.01
		await get_tree().create_timer(0.01).timeout
	%MouseBlocker.visible = false
	%CustomerTimer.start()
	fadeOutFinish.emit()

func loopMusic():
	await $Music.finished
	$Music.play()

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
	failed()
	generate_customer()


func _on_bookbutton_pressed():
	if not %Book/AnimationPlayer.is_playing():
		$BookOpen.play()
		book_open = not book_open
		%BookOpen.visible = book_open
		%BookClosed.visible = not book_open
		$Ritual/BookOpen.visible =  book_open
		$Ritual/BookClosed.visible = not book_open
		%Book._on_button_pressed()

func _on_cure_button_pressed():
	var cure
	var item
	Autoload.use_chalk.emit("Empty")
	for _c in %Shop.get_children():
		if _c is Ailments:
			print(_c.cure)
			cure = _c.cure
	for _i in $Ritual/CirclePos.get_children():
		if _i is Ingredient:
			print(_i.identifier)
			item = _i.identifier
	if cure == item:
		%CustomerTimer.start()
		generate_customer()
	else:
		failed()
		generate_customer()
		%CustomerTimer.start()
