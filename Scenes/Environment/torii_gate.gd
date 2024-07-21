extends "res://EnvironmentObject.gd"

@onready var decay_timer: Timer = $DecayTimer

func sprite_shaker_shake():
	Global.play_sound("EnvSFX", "rock" + str(randi_range(2, 3)), 0, global_position)
	sprite_shaker.shake()

func _on_health_handler_died(value, cause, hurtbox_global_position) -> void:
	if state == "decaying":
		return
	
	if state == "dead":
		
		$HurtBoxHandler.strength = 40
		
		
		if cause == "Exploded":
			sprite.flip_h = bool(randi_range(1, 0))
			anim_player.play("fallen")
		
		return
	
	state = "dead"
	
	anim_player.play("fallen")
	
	decay_timer.start(randi_range(12, 19))

func _on_decay_timer_timeout():
	if anim_player.is_playing():
		await anim_player.animation_finished
	state = "decaying"
	anim_player.play("decay")
