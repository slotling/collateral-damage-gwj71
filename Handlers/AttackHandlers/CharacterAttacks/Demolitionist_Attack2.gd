extends "res://Handlers/AttackHandlers/CharacterAttack.gd"

var explosion_preload = preload("res://Scenes/Entities/Projectiles/Variations/demolitionist_self_explosion.tscn")

func execute() -> void:
	var instance = explosion_preload.instantiate()
	instance.init(get_parent().global_position)
	Global.add_world_node(instance)
