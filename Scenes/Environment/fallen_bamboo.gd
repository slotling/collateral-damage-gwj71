extends "res://EnvironmentObject.gd"



var facing: Vector2 = Vector2.ZERO

func _ready():
	var anim_name = str(int(facing.x)) + "_" + str(int(facing.y))
	await get_tree().create_timer(randf_range(0.01, 0.1)).timeout
	anim_player.play(anim_name)

func sprite_shaker_shake():
	Global.play_sound("EnvSFX", "bamboo" + str(randi_range(1, 3)), 0, global_position)
	sprite_shaker.shake()

func _on_decay_timer_timeout():
	state = "decaying"
	anim_player.play("decay")
