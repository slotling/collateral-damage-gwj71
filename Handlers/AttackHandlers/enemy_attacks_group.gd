extends Node

@export var range:int = 30*32

@onready var enemy: Enemy = get_parent()
@onready var player: Player = get_tree().get_first_node_in_group("player")

func _ready():
	randomize()

var in_range := false
var ongoing := false

func check_range():
	in_range = player.global_position.distance_to(enemy.global_position) < range

func attack():
	if ongoing || !in_range:
		return
	
	var usable_attacks: Array = []
	for i in get_children():
		if !i.disabled:
			usable_attacks.append(i)
	
	if usable_attacks.size() == 0:
		return
		
	var attack_chosen: EnemyAttack = usable_attacks.pick_random()
	ongoing = true
	await attack_chosen.execute()
	ongoing = false

func _process(delta):
	check_range()
	attack()
