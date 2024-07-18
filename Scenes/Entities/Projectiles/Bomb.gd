extends Node2D
class_name Bomb

var end_position:Vector2
@export var CURVE_SPEED = 500
@export var ROTATE_DEGREES_SPEED = 360*2

func init(from=Vector2.ZERO, to=Vector2.ZERO) -> void: # global positions
	global_position = from
	$UpCurvePath.pos1 = from-global_position
	$UpCurvePath.pos2 = to-global_position
	end_position = to

func _ready() -> void:
	pass

func _process(delta) -> void:
	if global_position.x <= end_position.x:
		$UpCurvePath/PathFollow2D/Sprite2D.rotation_degrees += ROTATE_DEGREES_SPEED * delta 
	else:
		$UpCurvePath/PathFollow2D/Sprite2D.rotation_degrees -= ROTATE_DEGREES_SPEED * delta 
	
	$UpCurvePath/PathFollow2D.progress += CURVE_SPEED * delta
	if $UpCurvePath/PathFollow2D.progress_ratio >= 1:
		detonate()

var explosion_preload = preload("res://Scenes/Entities/Projectiles/explosion.tscn")

func detonate() -> void:
	var instance = explosion_preload.instantiate()
	instance.init(end_position)
	Global.add_world_node(instance)

	queue_free()
