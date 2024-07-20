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
			
			while fall_vector.x == 0:
				fall_vector.x = randi_range(-1, 1)
			
			_on_regrow_timer_timeout()
			
			fallen_bamboo_instance.facing = fall_vector
			fallen_bamboo_instance.global_position = global_position + (fall_vector * randi_range(8, 10))
			fallen_bamboo_instance.global_scale = global_scale
			
			Global.add_world_node(fallen_bamboo_instance)
			
			anim_player.play("fallen")

func _on_regrow_timer_timeout():
	
	if health_handler.health >= health_handler.max_health:
		state = "alive"
		anim_player.play("grow")
		return
	
	health_handler.affect(randi_range(5, 10), "Heal", global_position)
	$RegrowTimer.start(2)

func _on_animation_player_current_animation_changed(anim_name):
	if anim_name == "hit":
		Global.play_sound("EnvSFX", "bamboo" + str(randi_range(1, 3)), 0, global_position)
