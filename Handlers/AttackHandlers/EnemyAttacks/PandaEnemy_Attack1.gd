extends EnemyAttack

var enemy_slash_preload = preload("res://Scenes/Entities/Projectiles/EnemySlash.tscn")

func execute() -> void:
	await get_tree().create_timer(0.25).timeout
	var instance = enemy_slash_preload.instantiate()
	var enemypos = enemy.global_position
	var playerpos = player.global_position
	instance.init(enemypos, rad_to_deg(enemypos.angle_to_point(playerpos)))
	Global.add_world_node(instance)
	
	await get_tree().create_timer(3).timeout
