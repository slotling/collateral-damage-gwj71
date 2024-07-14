extends Area2D

signal hit(strength: int, cause: String)
signal cooldown_end()

@export var immune := false
@export var health : int = 200
@export_range(0.01, 5) var cooldown_time := 0.5

@onready var cooldown_timer = $CooldownTimer

func _on_cooldown_timer_timeout():
	cooldown_end.emit()
	monitoring = true

func get_hit(str, cause):
	if cooldown_timer.is_stopped():
		set_deferred("monitoring", false)
		cooldown_timer.start(cooldown_time)
		hit.emit(str, cause)

func _on_area_entered(area):
	if area.is_in_group("hurtbox"):
		get_hit(area.strength, area.cause)
