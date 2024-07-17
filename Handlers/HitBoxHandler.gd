extends Area2D

signal hit(strength: int, cause: String, hurtbox_global_position: Vector2)
signal cooldown_end()

@export var immune := false
@export_range(0.01, 5) var cooldown_time := 0.5

@onready var cooldown_timer = $CooldownTimer

func _on_cooldown_timer_timeout():
	cooldown_end.emit()
	monitoring = true

func get_hit(str, cause, hurtbox_global_position):
	if cooldown_timer.is_stopped():
		set_deferred("monitoring", false)
		cooldown_timer.start(cooldown_time)
		hit.emit(str, cause, hurtbox_global_position)

func _on_area_entered(area):
	if area.is_in_group("hurtbox"):
		var parent = get_parent()
		if area.avoid_damaging_enemies && parent.is_in_group("enemy"):
			return
		
		if area.avoid_damaging_player && parent.is_in_group("player"):
			return
			
		get_hit(area.strength, area.cause, area.global_position)
