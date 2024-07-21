extends Node2D

func init(pos):
	global_position = pos

func _ready():
	randomize()
	$Sprite2D.frame = randi_range(0, 2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
