extends CharacterBody2D

@export var flammable: bool = false
@export var regeneratable: bool = false
@export var movable: bool = false
@export var auto_disable_collision: bool = true

@onready var sprite: Sprite2D = $Sprite2D
@onready var sprite_shaker: Node = $SpriteShaker
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var health_handler: Node = $HealthHandler

var state: String = "alive"

func _ready() -> void:
	pass

func _physics_process(_delta) -> void:
	if movable:
		velocity = lerp(velocity, Vector2.ZERO, 0.1)
		
		move_and_slide()

func calculate_fall_to_vector(hurtbox_global_position) -> Vector2:
	return -round(global_position.direction_to(hurtbox_global_position))

func soft_anim_play(anim:String) -> void:
	if anim_player.has_animation(anim):
		anim_player.play(anim)

func _on_health_handler_hit(value, cause, hurtbox_global_position) -> void:
	if state == "dead" or state == "decaying":
		return
	
	soft_anim_play("hit")
	sprite_shaker.shake()

func _on_health_handler_died(value, cause, hurtbox_global_position) -> void:
	pass

func _on_hit_box_handler_hit(strength, cause, hurtbox_global_position) -> void:
	health_handler.affect(-abs(strength), cause, hurtbox_global_position)

func _process(delta):
	if auto_disable_collision:
		$CollisionShape2D.disabled = (state == "dead" or state == "decaying")
