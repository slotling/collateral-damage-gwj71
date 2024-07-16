extends Node
signal wave_completed
signal all_waves_finished

@onready var cooldown_timer = $WaveCooldown
@onready var camera = get_tree().get_first_node_in_group("main_cam")
@onready var enemy = preload("res://Scenes/Entities/enemy.tscn")

@export var enabled = true

@export var wave_cooldown: int
@export var max_enemy_count: int
@export var max_wave_count: int
@export var spawning_distance: int

enum enemy_types {
	terminator, killer_panda
}

var enemy_count: int = 0

var current_wave = 0
func _ready():
	randomize()

func start_wave():
	if !enabled:
		return
	
	for n in range(max_enemy_count):
		enemy_count = n
		
		spawn_enemy()

func get_enemy_type() -> int:
	var enemy_type = randi_range(0, enemy_types.size() - 1)
	return enemy_type

func get_random_position():
	if camera:
		var camera_position = camera.global_position
		var rand_degrees = randi_range(0, 360)
		var spawn_position = camera_position + Vector2(spawning_distance, 0).rotated(deg_to_rad(rand_degrees))
		return spawn_position
	return

func spawn_enemy():
	var enemy_instance = enemy.instantiate()
	var enemy_type = get_enemy_type()
	var health_handler = enemy_instance.health_handler
	
	enemy_count += 1
	enemy_instance.type = str(enemy_type)
	enemy_instance.global_position = get_random_position()
	
	if health_handler:
		health_handler.connect("died", update_enemy_counter)

	get_parent().add_child(enemy_instance)

	if enemy_count == 0:
		wave_completed.emit()

func _on_wave_completed():
	cooldown_timer.start(wave_cooldown)
	enemy_count = 0

func _on_wave_cooldown_timeout():
	if current_wave < max_wave_count:
		start_wave()
		print("wave started")
	else:
		all_waves_finished.emit()

func update_enemy_counter():
	enemy_count += 1
