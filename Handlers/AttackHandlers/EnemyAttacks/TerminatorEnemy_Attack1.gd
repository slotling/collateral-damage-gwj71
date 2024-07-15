extends EnemyAttack

func execute():
	print("fuck off (waiting 1s)")
	await get_tree().create_timer(1).timeout
