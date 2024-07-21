extends CharacterBody2D
class_name Player

@onready var movement_handler: Node = $MovementHandler
@onready var health_handler: Node = $HealthHandler
@onready var primary_attack: Node = $CharacterAttack1
@onready var secondary_attack: Node = $CharacterAttack2
@onready var game_ui: Node = $GUI

var state: String = "idle"

func _physics_process(delta):
	movement_handler.dir = Input.get_vector("left", "right", "forward", "backward").normalized()
	
	movement_handler.running = Input.is_action_pressed("run")
	
	move_and_slide()
	
func _on_health_handler_died(value, cause, hurtbox_global_position):
	state = "dead"

func _on_hit_box_handler_hit(strength, cause, hurtbox_global_position):
	health_handler.affect(-abs(strength), cause, hurtbox_global_position)

func _on_health_handler_hit(value, cause, hurtbox_global_position):
	game_ui.heart_shaker.shake()
	game_ui.icon_shaker.shake()
