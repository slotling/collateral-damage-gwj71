extends "res://Handlers/AttackHandlers/CharacterAttack.gd"

var oil_preload = preload("res://Scenes/Entities/Projectiles/oil_splash.tscn")

func execute() -> void:
	var instance = oil_preload.instantiate()
	instance.init(get_parent().global_position)
	Global.add_world_node(instance)
