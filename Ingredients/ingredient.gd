extends Node2D
class_name Ingredient

@export var is_dust := false
@export var is_chalk := false
@export var identifier := "" ## A unique name per ingredient
@export var source := false ## Used if we have the ingredient itself on the shelf

var hovered := false
var following_mouse := false : 
	set(v):
		if v:
			global_position = get_global_mouse_position()
		following_mouse = v
var click_pos := Vector2.ZERO # Used to check if mouse is quickly moved
var current_point : Area2D : # Corresponds to the circle's placement hitbox that the ingredient is on
	set(v):
		if v == null:
			if current_point.get_parent() is RitualCircle:
				current_point.get_parent().ingredients.erase(current_point)
			else:
				current_point.get_parent().get_parent().ingredients.erase(current_point)
		else:
			global_position = v.global_position
			if v.get_parent() is RitualCircle:
				v.get_parent().ingredients[v] = self
			else:
				if v.get_parent() is RitualCircle:
					v.get_parent().ingredients[v] = self
				else:
					v.get_parent().get_parent().ingredients[v] = self
		current_point = v


func _ready():
	$Area2D.set_collision_mask_value(3, not is_dust and not is_chalk)
	$Area2D.set_collision_mask_value(4, is_dust or is_chalk)
	
	%Sprite.animation = identifier
	%Sprite.frame = source
	
	if not OS.is_debug_build():
		$ClickableArea/DevVisual.visible = false
		$ClickableArea/DevVisual.queue_free()
	else:
		$ClickableArea/DevVisual/Label.text = identifier


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
					%ClickTimer.start() # ClickTimer allows for clicking instead of dragging
					click_pos = get_global_mouse_position()
				else:
					if not %ClickTimer.is_stopped():
						pick_up()


func pick_up():
	%ClickTimer.stop()
	click_pos = Vector2.ZERO
	
	if source: # Clones ingrendient and removes source tag
		var new_ingredient : Node2D = duplicate()
		new_ingredient.following_mouse = true
		new_ingredient.source = false
		
		get_parent().get_parent().add_child(new_ingredient)
	else: # Moves existing ingredient
		following_mouse = true
		
		if current_point:
			current_point = null


func drop():
	following_mouse = false
	if not $Area2D.has_overlapping_areas():
		fail_placement()
	else:
		var area : Area2D = $Area2D.get_overlapping_areas()[0]
		
		if is_chalk:
			Autoload.use_chalk.emit(identifier)
			queue_free()
		elif is_dust:
			area.get_parent().complete_ritual(identifier)
			queue_free()
		else:
			var area_parent
			if area.get_parent() is RitualCircle:
				area_parent = area.get_parent()
			else:
				area_parent = area.get_parent().get_parent()
			if area_parent.ingredients.has(area): # Checks if the spot is taken
				fail_placement()
			else:
				current_point = area


func set_sprite():
	match identifier:
		"":
			pass


func fail_placement():
	vanish()
	# Vanish is separate in case we want misplaced items to go back to where they were


func vanish():
	#await get_tree().create_timer(0.1).timeout
	queue_free()
	# TODO: Add a vanishing effect or something


func _on_clickable_area_mouse_entered():
	hovered = true


func _on_clickable_area_mouse_exited():
	hovered = false


func _on_click_timer_timeout():
	pick_up()
