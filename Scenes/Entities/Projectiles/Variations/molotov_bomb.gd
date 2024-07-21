extends Bomb

var explosion_preload = preload("res://Scenes/Entities/Projectiles/Variations/molotov_explosion.tscn")

func _ready() -> void:
	explosion_preload = preload("res://Scenes/Entities/Projectiles/Variations/molotov_explosion.tscn")
	Global.play_sound("PlayerSFX", "molotov_t" + str(randi_range(1, 3)), 0, global_position)
