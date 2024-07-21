extends Node

@export var stamina := 1000.0
@export var max_stamina := 1000.0
@export var max_speed := 250.0
@export var running_speed_boost_multiplier := 2.0
@export var knockback_multiplier := 50
@export_node_path("AnimatedSprite2D") var sprite_path

var speed_boost := 0
var running := false
var dir := Vector2.ZERO
var state := "idle"

var bot_sprint_condition: bool = true # tells bots whether to sprint or not
var bot_sprint_activation_threshold: int = 1000

func _ready():
	bot_sprint_activation_threshold = randi_range(200, 1000)
	await get_tree().physics_frame
	get_parent().health_handler.connect("hit", push)

func push(damage, cause, hurtbox_global_position):
	var push_vector = (hurtbox_global_position.direction_to(get_parent().global_position)).normalized()
	get_parent().velocity -= push_vector * (damage * knockback_multiplier)

func _physics_process(_delta):
	## Validity Check
	if get_parent().state == "dead":
		get_parent().velocity = lerp(get_parent().velocity, Vector2.ZERO, 0.6)
		return
	
	## Handle Velocity
	if dir != Vector2.ZERO: # Proceed If Walking
		get_parent().state = "walk"
		get_parent().velocity = lerp(get_parent().velocity, dir * (lerp(max_speed, max_speed + speed_boost, 0.7)), 0.4)
	else: # Proceed If Idle
		get_parent().state = "idle"
		get_parent().velocity = lerp(get_parent().velocity, Vector2.ZERO, 0.2)
	
	state = get_parent().state
	
	## Handle bot sprint condition
	if stamina >= bot_sprint_activation_threshold:
		bot_sprint_condition = true
	elif stamina <= randi_range(-100, 100):
		bot_sprint_condition = false
		bot_sprint_activation_threshold = randi_range(200, 1000)
	
	## Handle Speed
	if running and stamina > -100 and state == "walk": # Proceed if stamina is drained AND is running
		speed_boost = stamina/max_stamina*(running_speed_boost_multiplier-1)*max_speed # Procedurally Generated Speed Boost
		## Drain Stamina Whilst Running
		stamina = clamp(stamina - 5, -100, INF) # Drain Stamina
	else: # Proceed if stamina is full OR is resting
		
		speed_boost = 0 # Remove Speed Boost
		## Recharge Stamina
		if stamina < max_stamina: # Prevent Overstamina
			
			if state == "idle": # Whilst Idle
				stamina = clamp(stamina + 4, -INF, max_stamina) # Recharge Stamina
			elif state == "walk": # Whilst Walking
				stamina = clamp(stamina + 1, -INF, max_stamina) # Recharge Stamina Slowly
