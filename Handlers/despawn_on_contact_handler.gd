extends Area2D

@export var strength := 10
@export var cause := "Unknown"
@export var avoid_contacting_enemies := false
@export var avoid_contacting_player := false
@export var avoid_contacting_world := false

func _on_body_entered(body):
	var parent = get_parent()
	if avoid_contacting_enemies && body.is_in_group("enemy"):
		return

	if avoid_contacting_player && body.is_in_group("player"):
		return

	if avoid_contacting_world && body.is_in_group("tilemap"):
		return

	parent.despawn()
