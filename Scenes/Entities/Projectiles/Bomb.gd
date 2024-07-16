extends Node2D
class_name Bomb

var end_position:Vector2

func init(from=Vector2.ZERO, to=Vector2.ZERO) -> void: # global positions
	global_position = from
	$UpCurvePath.pos1 = from-global_position
	$UpCurvePath.pos2 = to-global_position
	end_position = to

func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta) -> void:
	$UpCurvePath/PathFollow2D.progress += 400 * delta
	if $UpCurvePath/PathFollow2D.progress_ratio >= 1:
		detonate()

var explosion_preload = preload("res://Scenes/Entities/Projectiles/explosion.tscn")

func detonate() -> void:
	var instance = explosion_preload.instantiate()
	instance.init(end_position)
	Global.add_world_node(instance)

	queue_free()
