extends Node

signal died(cause)
signal hit(cause)

@export var health : int = 100
@export var max_health : int = 100

func affect(value, cause):
	health = clamp(health + value, 0, max_health)
	hit.emit(cause)
	if health == 0:
		died.emit(cause)

