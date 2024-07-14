extends CharacterBody2D

const ACCEL = 4000.0
const MAX_SPEED = 400.0


func _physics_process(delta):
	var direction = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down"))
	var delta_accel = ACCEL * delta
	if direction.x:
		velocity.x += direction.x * delta_accel
	else:
		velocity.x = move_toward(velocity.x, 0, delta_accel)
	velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)

	if direction.y:
		velocity.y += direction.y * delta_accel
	else:
		velocity.y = move_toward(velocity.y, 0, delta_accel)
	velocity.y = clamp(velocity.y, -MAX_SPEED, MAX_SPEED)
	
	

	move_and_slide()
