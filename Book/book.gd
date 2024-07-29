extends Control

var out := false
var current_page := 0

func _ready():
	switch_to_page(0)


func switch_to_page(num : int):
	for c in %Pages.get_children():
		c.visible = false
	%Pages.get_child(num).visible = true
	
	# TODO: Maybe change or remove this part
	#%TabDemon.visible = not %PageDemon1.visible
	#%TabPride.visible = not %PagePride1.visible
	#%TabGreed.visible = not %PageGreed1.visible
	#%TabWrath.visible = not %PageWrath1.visible
	#%TabEnvy.visible = not %PageEnvy1.visible
	#%TabLust.visible = not %PageLust1.visible
	#%TabGluttony.visible = not %PageGluttony1.visible
	#%TabSloth.visible = not %PageSloth1.visible
	
	%PageLeft.visible = num > 0
	%PageRight.visible = num < %Pages.get_child_count() - 1
	
	current_page = num
	%PageNumber.text = str(num + 1)


func _on_tab_pressed(num):
	switch_to_page(num)


func _on_button_pressed():
	if not $AnimationPlayer.is_playing():
		if out:
			$AnimationPlayer.play("Go In")
		else:
			$AnimationPlayer.play("Go Out")
		out = not out


func _on_page_left_pressed():
	switch_to_page(current_page - 1)


func _on_page_right_pressed():
	switch_to_page(current_page + 1)


func _on_button_mouse_entered():
	_on_button_pressed()
