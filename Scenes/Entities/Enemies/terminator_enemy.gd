extends Enemy

@onready var anim_player = $AnimationPlayer



func _process(delta):
	sprite.flip_h = !bool(sign(dir.x) + 1)

func _on_state_changed(new_state):
	if new_state == "walk" or new_state == "idle":
		anim_player.play(new_state)
