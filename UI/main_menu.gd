extends Control

@export var title_screen := true

var shop : PackedScene = load("res://shop.tscn")
var main_menu : PackedScene = load("res://UI/main_menu.tscn")

func _ready():
	%MainButtons.visible = true
	%HowToPlay.visible = false
	%Options.visible = false
	%SubMenus.visible = false
	
	visible = title_screen
	%ToMainMenu.visible = not title_screen
	%StartGame.visible = title_screen
	
	if title_screen:
		pass # TODO: Play fade in animation


func _input(event):
	if not title_screen:
		if event is InputEventKey:
			if event.keycode == KEY_ESCAPE and event.pressed and not event.echo:
				visible = not visible
				get_tree().paused = not get_tree().paused
				if not visible:
					_on_back_to_menu_pressed()


func _on_start_game_pressed():
	get_tree().change_scene_to_packed(shop)


func _on_to_main_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_packed(main_menu)


func _on_options_button_pressed():
	%SubMenus.visible = true
	%MainButtons.visible = false
	%Options.visible = true
	%HowToPlay.visible = false


func _on_how_to_button_pressed():
	%SubMenus.visible = true
	%MainButtons.visible = false
	%HowToPlay.visible = true
	%Options.visible = false


func _on_back_to_menu_pressed():
	%SubMenus.visible = false
	%MainButtons.visible = true


func _on_quit_pressed():
	get_tree().quit()
