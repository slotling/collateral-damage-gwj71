extends Node
class_name EnemyAttack

@export var disabled:bool = false

@onready var enemy: Enemy = get_parent().get_parent()
@onready var player: Player = get_tree().get_first_node_in_group("player")

func _ready():
	pass

func _process(delta):
	pass

func execute():
	pass
