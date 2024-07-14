extends Node

@export var sprite: Sprite2D
@export var default_offset: Vector2
@export var duration: int = 12
@export var pause_interval: float = 0.05
@export var offset_range: int = 2

func shake():
	for i in duration:
		sprite.offset = default_offset
		sprite.offset.x += randi_range(-offset_range, offset_range)
		sprite.offset.y += randi_range(-offset_range, offset_range)
		await get_tree().create_timer(pause_interval).timeout
	sprite.offset = default_offset
