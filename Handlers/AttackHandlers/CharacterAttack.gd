extends Node

@export var is_secondary_attack := false # will make it use secondary attack button if true
signal execute_attack()

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var pressed := Input.is_action_just_pressed("attack1") if !is_secondary_attack else Input.is_action_just_pressed("attack2")
	if pressed and $CooldownTimer.is_stopped() and get_parent().state != "dead":
		execute()
		$CooldownTimer.start()

func execute():
	pass
