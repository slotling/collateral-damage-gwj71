extends Node2D

signal died(value, cause, hurtbox_global_position)
signal hit(value, cause, hurtbox_global_position)

@export var health : int = 100
@export var max_health : int = 100
@export var regen : bool = false
@export var seconds_to_regen : float = 1.0
@export var show_bar : bool = false

func _ready():
	$HealthBar.visible = show_bar
	$RegenTimer.wait_time = seconds_to_regen

func _physics_process(delta) -> void:
	$HealthBar.max_value = max_health
	$HealthBar.value = health

func affect(value, cause, hurtbox_global_position):
	health = clamp(health + value, 0, max_health)
	
	if value < 1:
		hit.emit(value, cause, hurtbox_global_position)
	
	if health <= 0:
		died.emit(value, cause, hurtbox_global_position)

func _on_hit_box_handler_hit(strength, cause, hurtbox_global_position):
	affect(-strength, cause, hurtbox_global_position)


func _on_regen_timer_timeout():
	if health >= max_health or !regen:
		return
	
	affect(randi_range(1, 10), "Healed", Vector2.ZERO)
