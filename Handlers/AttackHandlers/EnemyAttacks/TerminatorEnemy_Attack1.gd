extends EnemyAttack

var enemy_bullet_preload = preload("res://Scenes/Entities/Projectiles/Bullet.tscn")

func execute() -> void:
	var instance = enemy_bullet_preload.instantiate()
	var enemypos = enemy.global_position
	var playerpos = player.global_position
	var direction = rad_to_deg(enemypos.angle_to_point(playerpos)) + randi_range(-15, 15)
	
	instance.init(enemypos, direction)
	Global.add_world_node(instance)
	
	await get_tree().create_timer(2).timeout
