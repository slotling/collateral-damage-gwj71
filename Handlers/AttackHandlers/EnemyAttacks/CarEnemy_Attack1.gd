extends EnemyAttack

var enemy_bullet_preload = preload("res://Scenes/Entities/Projectiles/Bullet.tscn")

func execute() -> void:
	for i in range(30):
		var instance = enemy_bullet_preload.instantiate()
		var enemypos = enemy.global_position
		var playerpos = player.global_position
		var direction = rad_to_deg(enemypos.angle_to_point(playerpos)) + randi_range(-10, 10)
		
		instance.init(enemypos, direction)
		Global.add_world_node(instance)
		
		await get_tree().create_timer(0.1).timeout
	
	await get_tree().create_timer(2).timeout
