extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")

func init(pos):
	global_position = pos

func _ready():
	await get_tree().create_timer(10).timeout
	despawn()

func _process(delta):
	if $StopTrackingTimer.is_stopped():
		global_position += Vector2(600*delta, 0).rotated(rotation)
	else:
		look_at(player.global_position)
		global_position += Vector2(300*delta, 0).rotated(rotation)

var explosion_preload = preload("res://Scenes/Entities/Projectiles/explosion.tscn")

func despawn():
	var instance = explosion_preload.instantiate()
	instance.init(global_position)
	Global.add_world_node(instance)
	queue_free()
