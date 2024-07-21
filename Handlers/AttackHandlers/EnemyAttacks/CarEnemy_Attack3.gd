extends EnemyAttack

var missle_preload = preload("res://Scenes/Entities/Projectiles/homing_missle.tscn")

func execute() -> void:
	Global.play_sound("EnemySFX", "car_e" + str(randi_range(1, 2)), 0, enemy.global_position)
	for i in range(2):
		var instance = missle_preload.instantiate()
		var enemypos = enemy.global_position
		var playerpos = player.global_position
		
		instance.init(enemypos)
		Global.add_world_node(instance)
		
		await get_tree().create_timer(2).timeout
	
	await get_tree().create_timer(2).timeout
