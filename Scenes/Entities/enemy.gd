extends CharacterBody2D

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var movement_handler: Node = $MovementHandler
@onready var health_handler: Node = $HealthHandler
@onready var soft_collision: Area2D = $SoftCollision

@export_enum("terminator", "killer_panda") var type: String = "terminator"
@export_category("Health Handler")
@export var health: int = 100
@export var max_health: int = 100
@export_category("Movement Handler")
@export var speed: int = 150
@export var max_stamina: int = 1000
@export var knockback_multiplier: int = 50

var state: String = "idle"
var dir: Vector2 = Vector2.ZERO
var target: CharacterBody2D = null

func _ready() -> void:
	
	custom_params_setup()
	
	target = get_tree().get_first_node_in_group("player")
	call_deferred("target_setup")

func custom_params_setup() -> void:
	for i in [
		"health",
		"max_health",
	]:
		health_handler.set(i, get(i))
	
	for i in [
		"speed",
		"max_stamina",
		"knockback_multiplier"
	]:
		movement_handler.set(i, get(i))

func target_setup() -> void:
	await get_tree().physics_frame
	if target:
		nav_agent.target_position = target.global_position

func navigate_dir() -> Vector2:
	if target:
		nav_agent.target_position = target.global_position
	
	return global_position.direction_to(nav_agent.get_next_path_position())

func _physics_process(delta: float) -> void:
	
	
	if soft_collision.is_colliding():
		velocity += soft_collision.get_push_vector() * delta * 1000
	
	movement_handler.dir = dir
	
	movement_handler.running = movement_handler.bot_sprint_condition
	
	move_and_slide()

func _on_health_handler_died(value, cause, hurtbox_global_position):
	queue_free()

func _on_hit_box_handler_hit(strength, cause, hurtbox_global_position):
	health_handler.affect(-abs(strength), cause, hurtbox_global_position)

func _on_reaction_time_timer_timeout():
	dir = navigate_dir()
