extends "res://EnvironmentObject.gd"



func sprite_shaker_shake():
	Global.play_sound("EnvSFX", "rock" + str(randi_range(2, 3)), 0, global_position)
	sprite_shaker.shake()
