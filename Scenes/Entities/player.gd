extends CharacterBody2D

@onready var movement_handler: Node = $MovementHandler
@onready var health_handler: Node = $HealthHandler

var state: String = "idle"

func _physics_process(delta):
	movement_handler.dir = Input.get_vector("left", "right", "forward", "backward").normalized()
	
	movement_handler.running = Input.is_action_pressed("run")
	
	move_and_slide()
	
func _on_health_handler_died(value, cause, hurtbox_global_position):
	state = "dead"

func _on_hit_box_handler_hit(strength, cause, hurtbox_global_position):
	health_handler.affect(-abs(strength), cause, hurtbox_global_position)
