extends Sprite2D

@onready var symbol_position = %Symbol.global_position
@onready var particle_position = %Particle.global_position
@onready var magnifying_position = global_position

# For magnifying glass
var hovered := false
var following_mouse := false :
	set(v):
		if v:
			move()
		following_mouse = v

func _process(delta):
	if following_mouse:
		move()
	else:
		global_position = magnifying_position

func _input(event):
	if event is InputEventMouseButton and hovered:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			if following_mouse:
				drop()
			else:
				pick_up()

func move():
	global_position = get_global_mouse_position()
	%Symbol.global_position = symbol_position
	%Particle.global_position = particle_position

func pick_up():
	following_mouse = true

func drop():
	following_mouse = false
	global_position = magnifying_position
	%Symbol.global_position = symbol_position
	%Particle.global_position = particle_position

func _on_mouse_entered():
	print('hovered')
	hovered = true

func _on_mouse_exited():
	print('not hovered')
	hovered = false
