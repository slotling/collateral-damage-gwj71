extends Node

@export var stamina := 1000
@export var max_stamina := 1000
@export var max_speed := 400
@export_node_path("AnimatedSprite2D") var sprite_path

var speed_boost := 0
var running := false
var dir := Vector2.ZERO
var state := "idle"

func _physics_process(_delta):
	## Validity Check
	if get_parent().state == "dead":
		return
	
	## Handle Velocity
	if dir != Vector2.ZERO: # Proceed If Walking
		get_parent().state = "walk"
		get_parent().velocity = lerp(get_parent().velocity, dir * (lerp(max_speed, max_speed + speed_boost, 0.7)), 0.4)
	else: # Proceed If Idle
		get_parent().state = "idle"
		get_parent().velocity = lerp(get_parent().velocity, Vector2.ZERO, 0.2)
	
	state = get_parent().state
	
	## Handle Anim Speed
	if running and stamina > -100 and state == "walk": # Proceed if stamina is drained AND is running
		
		speed_boost = int(float(stamina)/2.0) # Procedurally Generated Speed Boost
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
