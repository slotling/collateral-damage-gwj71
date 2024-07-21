extends EnemyAttack

var terminator_enemy_preload = preload("res://Scenes/Entities/Enemies/terminator_enemy.tscn")

func execute() -> void:
	for i in range(3):
		var instance = terminator_enemy_preload.instantiate()
		var enemypos = enemy.global_position
		var playerpos = player.global_position
		
		instance.init(enemypos + Vector2(randi_range(-64, 64), randi_range(-64, 64)))
		Global.add_world_node(instance)
		
		await get_tree().create_timer(0.5).timeout
	
	await get_tree().create_timer(5).timeout
