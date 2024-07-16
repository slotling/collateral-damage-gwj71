extends StaticBody2D

@export_enum("test_obj", "bamboo", "small_rock", "gate") var type: String = "test_obj" # + "_cshape.tres"

@export var flammable: bool = false
@export var regeneration_time: float = 0.0

@onready var sprite: Sprite2D = $Sprite2D
@onready var sprite_shaker: Node = $SpriteShaker
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var health_handler: Node = $HealthHandler

var state: String = "default" # default, fire, fallen

func _ready() -> void:
	pass

func instantiate_debri(value, cause, hurtbox_global_position) -> void:
	var fall_to_vector: Vector2 = -round(global_position.direction_to(hurtbox_global_position))

func _on_health_handler_hit(value, cause, hurtbox_global_position) -> void:
	sprite_shaker.shake()

func _on_health_handler_died(value, cause, hurtbox_global_position) -> void:
	instantiate_debri(value, cause, hurtbox_global_position)
	
	if regeneration_time <= 0.0:
		queue_free()

func _on_hit_box_handler_hit(strength, cause, hurtbox_global_position):
	health_handler.affect(-abs(strength), cause, hurtbox_global_position)
