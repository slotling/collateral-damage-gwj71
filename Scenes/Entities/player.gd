extends CharacterBody2D

@onready var movement_handler: Node = $MovementHandler

var state: String = "idle"

func _physics_process(delta):
	movement_handler.dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	
	movement_handler.running = Input.is_action_pressed("run")
	
	move_and_slide()


