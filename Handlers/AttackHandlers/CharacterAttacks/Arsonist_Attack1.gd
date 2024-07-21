extends "res://Handlers/AttackHandlers/CharacterAttack.gd"

var bomb_preload = preload("res://Scenes/Entities/Projectiles/Variations/molotov_bomb.tscn")

func execute() -> void:
	var instance: Bomb = bomb_preload.instantiate()
	instance.init(get_parent().global_position, get_parent().get_global_mouse_position())
	Global.add_world_node(instance)
