extends "res://EnvironmentObject.gd"

const fallen_bamboo = preload("res://Scenes/Environment/fallen_bamboo.tscn")

func _ready():
	pass

func _on_health_handler_died(value, cause, hurtbox_global_position) -> void:
	if state == "dead":
		return
	
	state = "dead"
	
	match cause:
		"Flamed":
			pass
		_:
			var fall_vector: Vector2 = calculate_fall_to_vector(hurtbox_global_position)
			var fallen_bamboo_instance = fallen_bamboo.instantiate()
			#fallen_bamboo_instance.global_position = global_position
			#fallen_bamboo_instance.global_scale = global_scale
			
			while fall_vector.x == 0:
				fall_vector.x = randi_range(-1, 1)
			
			_on_regrow_timer_timeout()
			
			fallen_bamboo_instance.facing = fall_vector
			fallen_bamboo_instance.position += Vector2(randi_range(-10, 10), randi_range(-10, 10))
			
			call_deferred("add_child", fallen_bamboo_instance)
			anim_player.play("fallen")

func _on_regrow_timer_timeout():
	
	if health_handler.health >= health_handler.max_health:
		state = "alive"
		anim_player.play("grow")
		return
	
	health_handler.health += 10
	$RegrowTimer.start(2)

