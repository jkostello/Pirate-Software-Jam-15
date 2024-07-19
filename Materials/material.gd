extends Node2D


@export var is_dust := false


func _ready():
		$Area2D.set_collision_mask_value(3, not is_dust)
		$Area2D.set_collision_mask_value(4, is_dust)

