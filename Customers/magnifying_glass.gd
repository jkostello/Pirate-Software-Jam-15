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
var click_pos := Vector2.ZERO


func _ready():
	modulate = Color(0,0,0,0)

func _process(delta):
	if following_mouse:
		move()
	else:
		global_position = magnifying_position
	if click_pos:
		if click_pos.distance_to(get_global_mouse_position()) > 5:
			pick_up()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if following_mouse:
				drop()
			elif hovered:
				if event.pressed:
					%ClickTimer.start() # ClickTimer allows for clicking instead of dragging
					click_pos = get_global_mouse_position()
				else:
					if not %ClickTimer.is_stopped():
						pick_up()

func move():
	global_position = get_global_mouse_position()
	%Symbol.global_position = symbol_position
	%Particle.global_position = particle_position

func pick_up():
	following_mouse = true
	%ClickTimer.stop()
	click_pos = Vector2.ZERO
	Autoload.glass_visible.emit(false)
	modulate = Color(1,1,1,1)

func drop():
	following_mouse = false
	global_position = magnifying_position
	%Symbol.global_position = symbol_position
	%Particle.global_position = particle_position
	Autoload.glass_visible.emit(true)
	modulate = Color(0,0,0,0)

func _on_mouse_entered():
	print('hovered')
	hovered = true

func _on_mouse_exited():
	print('not hovered')
	hovered = false
