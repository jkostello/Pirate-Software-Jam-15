extends Node2D
# Name up for debate (material/ingredient/etc)

@export var is_dust := false

var source := true # Used if we have the material itself on the shelf
var hovered := false
var following_mouse := false
var click_pos := Vector2.ZERO

func _ready():
	$Area2D.set_collision_mask_value(3, not is_dust)
	$Area2D.set_collision_mask_value(4, is_dust)


func _process(delta):
	if following_mouse:
		global_position = get_global_mouse_position()
	if click_pos:
		if click_pos.distance_to(get_global_mouse_position()) > 5:
			pick_up()
			


func _input(event):
	if event is InputEventMouseButton and hovered:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if following_mouse:
				drop()
			else:
				if event.pressed:
					%ClickTimer.start()
					click_pos = get_global_mouse_position()
				else:
					if not %ClickTimer.is_stopped():
						pick_up()


func pick_up():
	%ClickTimer.stop()
	click_pos = Vector2.ZERO
	
	if source:
		var new_material : Node2D = duplicate()
		get_tree().current_scene.add_child(new_material)
		new_material.following_mouse = true
		new_material.source = false
	else:
		following_mouse = true


func drop():
	following_mouse = false
	if not $Area2D.has_overlapping_areas():
		queue_free()
		pass # Add a vanishing effect or something due to invalid placement (maybe in separate function)
	else:
		var area : Area2D = $Area2D.get_overlapping_areas()[0]
		
		if is_dust:
			area.get_parent().complete_ritual()
		else:
			# This can be changed depending on if we want it to snap on drop or while held 
			# Also needs to check the circle to see if the spot is taken (maybe swap held if so)
			global_position = area.global_position


func _on_clickable_area_mouse_entered():
	hovered = true


func _on_clickable_area_mouse_exited():
	hovered = false


func _on_click_timer_timeout():
	pick_up()
