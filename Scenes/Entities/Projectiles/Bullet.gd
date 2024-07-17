extends Node2D
class_name Bullet

@export var SPEED = 500

func init(pos, rot_deg):
	global_position = pos
	rotation_degrees = rot_deg

func _ready():
	await get_tree().create_timer(10).timeout
	queue_free()

func _process(delta):
	global_position += Vector2(SPEED*delta, 0).rotated(rotation)

func despawn():
	queue_free()
