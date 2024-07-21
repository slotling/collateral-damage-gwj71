extends Node2D

@export var explosionFrame = 0

func init(pos: Vector2): # global positions
	global_position = pos

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.play_sound("PlayerSFX", "bomb" + str(randi_range(1, 3)), 0, global_position)
	$AnimationPlayer.play("explosion")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in range($Sprites.get_children().size()):
		$Sprites.get_child(i).frame = explosionFrame

	$Sprites.visible = $AnimationPlayer.is_playing()

func _on_explosion_active_timer_timeout():
	$HurtBoxHandler/CollisionShape2D.disabled = true

func _on_despawn_timer_timeout():
	queue_free()
