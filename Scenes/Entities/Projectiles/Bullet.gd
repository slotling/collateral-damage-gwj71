extends Node2D
class_name Bullet

@export var SPEED = 500

var frame_no: int = 0

func init(pos, rot_deg):
	global_position = pos
	rotation_degrees = rot_deg

func _ready():
	await get_tree().create_timer(10).timeout
	despawn()

func _physics_process(_delta):
	$Icon.frame = frame_no % 3
	frame_no += 1
	await get_tree().create_timer(0.5).timeout

func _process(delta):
	global_position += Vector2(SPEED*delta, 0).rotated(rotation)

func despawn():
	queue_free()
