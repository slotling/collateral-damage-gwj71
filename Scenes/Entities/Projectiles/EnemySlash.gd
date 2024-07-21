extends Node2D

func init(pos, rot_deg):
	global_position = pos
	rotation_degrees = rot_deg

func _ready():
	Global.play_sound("EnemySFX", "panda_a" + str(randi_range(1, 3)), 0, global_position)
	await get_tree().create_timer(0.1).timeout
	queue_free()

func _process(delta):
	pass

func despawn():
	queue_free()
