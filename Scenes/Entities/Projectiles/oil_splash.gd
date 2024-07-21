extends Node2D

func init(pos):
	global_position = pos

func _ready():
	randomize()
	$Sprite2D.frame = randi_range(0, 2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
var explosion_preload = preload("res://Scenes/Entities/Projectiles/Variations/molotov_explosion.tscn")

func detonate() -> void:
	await get_tree().create_timer(0.1).timeout
	
	var instance = explosion_preload.instantiate()
	instance.init(global_position)
	Global.add_world_node(instance)

	queue_free()

func _on_hit_box_handler_hit(strength, cause, hurtbox_global_position):
	detonate()
