extends Node
class_name SpriteShaker

@export var sprite: Node
@export var offset_property: String = "offset"
@export var duration: int = 12
@export var pause_interval: float = 0.05
@export var offset_range: int = 2
@export var restore_default_offsets: bool = true

var default_offset: Vector2
var global_random_offset: Vector2 = Vector2.ZERO

var is_shaking: bool = false

func shake() -> void:
	if is_shaking:
		return
	
	is_shaking = true
	
	var sprites_to_offset: Array = [sprite]
	var original_offsets_list: Array = [sprite.get(offset_property)]
	
	for sprite_child in sprite.get_children():
		if sprite_child is Sprite2D:
			sprites_to_offset.append(sprite_child)
			original_offsets_list.append(sprite_child.get(offset_property))
	
	for current_sprite_idx in sprites_to_offset.size():
		soft_shake(sprites_to_offset[current_sprite_idx], original_offsets_list[current_sprite_idx])
	

func set_global_random_offset(sprite_to_watch):
	if sprite_to_watch != sprite:
		return
	global_random_offset.x = randi_range(-offset_range, offset_range)
	global_random_offset.y = randi_range(-offset_range, offset_range)

func soft_shake(current_sprite, offset) -> void:
	
	for i in duration:
		
		current_sprite.set(offset_property, offset)
		current_sprite.set(offset_property, current_sprite.get(offset_property) + global_random_offset)
		set_global_random_offset(current_sprite)
		await get_tree().create_timer(pause_interval).timeout
	
	if restore_default_offsets:
		current_sprite.set(offset_property, offset)
	
	is_shaking = false
