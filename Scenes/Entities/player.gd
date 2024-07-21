extends CharacterBody2D
class_name Player

signal state_changed(new_state)

@onready var movement_handler: Node = $MovementHandler
@onready var health_handler: Node = $HealthHandler
@onready var primary_attack: Node = $CharacterAttack1
@onready var secondary_attack: Node = $CharacterAttack2
@onready var sprite: Sprite2D = $Sprite2D
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var game_ui: Node = $GUI

@export var icon_texture: Texture2D = null

var state: String = "idle"
var prev_state: String = "idle"

func _ready():
	game_ui.icon.texture = icon_texture

func _physics_process(delta):
	if prev_state != state:
		state_changed.emit(state)
	
	movement_handler.dir = Input.get_vector("left", "right", "forward", "backward").normalized()
	
	movement_handler.running = Input.is_action_pressed("run")
	
	if movement_handler.dir.x != 0:
		sprite.flip_h = !bool(sign(movement_handler.dir.x) + 1)
	
	prev_state = state
	
	move_and_slide()
	
func _on_health_handler_died(value, cause, hurtbox_global_position):
	state = "dead"

func _on_hit_box_handler_hit(strength, cause, hurtbox_global_position):
	health_handler.affect(-abs(strength), cause, hurtbox_global_position)

func _on_health_handler_hit(value, cause, hurtbox_global_position):
	game_ui.heart_shaker.shake()
	game_ui.icon_shaker.shake()



func _on_state_changed(new_state):
	if new_state == "walk" or new_state == "idle" or new_state == "dead":
		anim_player.play(new_state)


func _on_character_attack_1_cooldown_end():
	game_ui.change_emotion("positive", 0.3, "default", true)

func _on_character_attack_2_cooldown_end():
	game_ui.change_emotion("positive", 1.0, "default", true)
