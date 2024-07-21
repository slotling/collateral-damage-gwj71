extends "res://EnvironmentObject.gd"





func _ready() -> void:
	sprite.frame = randi_range(0, 3)

func _on_health_handler_died(value, cause, hurtbox_global_position) -> void:
	var fall_vector := calculate_fall_to_vector(hurtbox_global_position)
	
	velocity += fall_vector * (value * randi_range(45, 100))
