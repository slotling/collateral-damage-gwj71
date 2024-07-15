extends Node2D

func init(pos: Vector2): # global positions
	global_position = pos

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_explosion_active_timer_timeout():
	$HurtBoxHandler/CollisionShape2D.disabled = true
	queue_free()
