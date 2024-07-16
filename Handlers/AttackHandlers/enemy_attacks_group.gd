extends Node

func _ready():
	randomize()

var ongoing := false

func attack():
	if ongoing || get_children().size() == 0:
		return
		
	var attack_chosen: EnemyAttack = get_children().pick_random()
	ongoing = true
	await attack_chosen.execute()
	ongoing = false

func _process(delta):
	attack()
