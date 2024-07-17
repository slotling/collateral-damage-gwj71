extends Area2D

@export var strength := 10
@export var cause := "Unknown"
@export var avoid_damaging_enemies := false
@export var avoid_damaging_player := false

func _on_body_entered(body):
	var parent = get_parent()
	if avoid_damaging_enemies && body.is_in_group("enemy"):
		return

	if avoid_damaging_player && body.is_in_group("player"):
		return
	
	parent.despawn()
