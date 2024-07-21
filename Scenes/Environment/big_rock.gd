extends "res://EnvironmentObject.gd"





func _ready() -> void:
	if !bool(randi_range(0, 10000)):
		sprite.frame = 0

func _on_health_handler_died(value, cause, hurtbox_global_position) -> void:
	var fall_vector := calculate_raw_fall_to_vector(hurtbox_global_position)
	
	var distance: Vector2 = abs(hurtbox_global_position - global_position)
	var iforgir := 200.0
	var thingx := remap(distance.x, iforgir, 0, 0.05, iforgir)
	var thingy := remap(distance.y, iforgir, 0, 0.05, iforgir)
	
	velocity += fall_vector * (abs(value) * Vector2(thingx, thingy) )
	
	$RockSliding.play()
	
	soft_anim_play("fallen")
	sprite_shaker.shake()
	
	await anim_player.animation_finished
	
	soft_anim_play("RESET")
	sprite_shaker.shake()
	$RockSliding.stop()

