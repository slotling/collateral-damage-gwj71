extends Node

@export var sprite: Sprite2D
@export var duration: int = 12
@export var pause_interval: float = 0.05
@export var offset_range: int = 2

var default_offset: Vector2
var global_random_offset: Vector2 = Vector2.ZERO

func shake() -> void:
	var sprites_to_offset: Array = [sprite]
	var original_offsets_list: Array = [sprite.offset]
	
	for sprite_child in sprite.get_children():
		if sprite_child is Sprite2D:
			sprites_to_offset.append(sprite_child)
			original_offsets_list.append(sprite_child.offset)
	
	for current_sprite_idx in sprites_to_offset.size():
		soft_shake(sprites_to_offset[current_sprite_idx], original_offsets_list[current_sprite_idx])

func set_global_random_offset(sprite_to_watch):
	if sprite_to_watch != sprite:
		return
	global_random_offset.x = randi_range(-offset_range, offset_range)
	global_random_offset.y = randi_range(-offset_range, offset_range)

func soft_shake(current_sprite, offset) -> void:
	
	for i in duration:
		
		current_sprite.offset = offset
		current_sprite.offset += global_random_offset
		set_global_random_offset(current_sprite)
		await get_tree().create_timer(pause_interval).timeout
		
	current_sprite.offset = offset
