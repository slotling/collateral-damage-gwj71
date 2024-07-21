extends Bomb

func _ready() -> void:
	Global.play_sound("PlayerSFX", "molotov_t" + str(randi_range(1, 3)), 0, global_position)
