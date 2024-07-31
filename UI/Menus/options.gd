extends VBoxContainer

@onready var fullscreen = false

func _ready():
	_on_fullscreen_button_toggled(fullscreen)

func _on_resolutions_item_selected(index):
	if index == 0:
		DisplayServer.window_set_size(Vector2i(1024, 576))
	if index == 1:
		DisplayServer.window_set_size(Vector2i(1280, 720))
	if index == 2:
		DisplayServer.window_set_size(Vector2i(1600, 900))
	if index == 3:
		DisplayServer.window_set_size(Vector2i(1920, 1080))

func _on_fullscreen_button_toggled(toggled_on):
	fullscreen = not fullscreen
	# Set windowed
	if (fullscreen):
		DisplayServer.window_set_mode(0, 0)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		_on_resolutions_item_selected(%Resolutions.selected)
	# Set fullscreen
	else:
		DisplayServer.window_set_mode(3, 0)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
