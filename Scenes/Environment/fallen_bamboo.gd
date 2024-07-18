extends "res://EnvironmentObject.gd"



var facing: Vector2 = Vector2.ZERO

func _ready():
	var anim_name = str(int(facing.x)) + "_" + str(int(facing.y))
	
	anim_player.play(anim_name)

func sprite_shaker_shake():
	sprite_shaker.shake()


func _on_decay_timer_timeout():
	anim_player.play("decay")
