extends Node2D

func init(pos, rot_deg):
	global_position = pos
	rotation_degrees = rot_deg

func _ready():
	await get_tree().create_timer(0.1).timeout
	queue_free()

func _process(delta):
	pass

func despawn():
	queue_free()
