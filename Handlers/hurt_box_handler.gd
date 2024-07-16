extends Area2D

@export var strength := 10
@export var cause := "Unknown"
@export_enum("enemy", "player", "enemy_and_player") var damage_to_type: String = "enemy_and_player"
