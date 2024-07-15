extends Node

signal died(cause)
signal hit(value, cause, hurtbox_global_position)

@export var health : int = 100
@export var max_health : int = 100

func affect(value, cause,hurtbox_global_position):
	health = clamp(health + value, 0, max_health)
	hit.emit(value, cause, hurtbox_global_position)
	if health == 0:
		died.emit(value, cause, hurtbox_global_position)

func _on_hit_box_handler_hit(strength, cause, hurtbox_global_position):
	affect(-strength, cause, hurtbox_global_position)
