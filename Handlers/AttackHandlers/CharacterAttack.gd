extends Node

signal cooldown_end()

@export var is_secondary_attack := false # will make it use secondary attack button if true
@onready var cooldown_timer: Timer = $CooldownTimer

signal execute_attack()

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var pressed := Input.is_action_just_pressed("attack1") if !is_secondary_attack else Input.is_action_just_pressed("attack2")
	if pressed and cooldown_timer.is_stopped() and get_parent().state != "dead":
		execute()
		cooldown_timer.start()

func execute():
	pass

func _on_cooldown_timer_timeout():
	cooldown_end.emit()



