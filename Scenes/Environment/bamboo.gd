extends "res://EnvironmentObject.gd"

const fallen_bamboo = preload("res://Scenes/Environment/fallen_bamboo.tscn")

func _ready():
	pass

func _on_health_handler_died(value, cause, hurtbox_global_position) -> void:
	
	match cause:
		"Exploded", "Unknown":
			var fall_vector: Vector2 = calculate_fall_to_vector(hurtbox_global_position)
			var fallen_bamboo_instance = fallen_bamboo.instantiate()
			fallen_bamboo_instance.global_position = global_position
