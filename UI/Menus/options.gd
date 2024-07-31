extends TabContainer


func _on_resolutions_item_selected(index):
	if index == 0:
		DisplayServer.window_set_size(Vector2i(1024, 576))
	if index == 1:
		DisplayServer.window_set_size(Vector2i(1280, 720))
	if index == 2:
		DisplayServer.window_set_size(Vector2i(1600, 900))
	if index == 3:
		DisplayServer.window_set_size(Vector2i(1920, 1080))
