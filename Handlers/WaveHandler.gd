extends Node

signal wave_completed
signal all_waves_finished
signal enemy_died

enum enemy_types {terminator, killer_panda}

@onready var cooldown_timer = $WaveCooldown
@onready var terrain_generator: Node2D = get_tree().get_first_node_in_group("terrain_generator")
@onready var enemy = preload("res://Scenes/Entities/enemy.tscn")
@export var enabled = true

@export var wave_cooldown: int
@export var max_enemy_count: int
@export var max_wave_count: int
@export var spawning_distance: int

var enemy_count: int = 0
var current_wave: int = 0

func _ready():
	randomize()

func start_wave():

	if !enabled:
		return
	
	for n in max_enemy_count:
		enemy_count = n + 1

		spawn_enemy()

func get_random_position(): 
	if terrain_generator:
		var spawnable_tiles = terrain_generator.spawnable_tiles
		var random_tile_pos = spawnable_tiles.pick_random()
		
		print(random_tile_pos)
		return random_tile_pos
	return Vector2.ZERO

func get_enemy_type() -> int:
	var enemy_type = randi_range(0, enemy_types.size() - 1)
	return enemy_type

func spawn_enemy():
	var enemy_instance = enemy.instantiate()
	var enemy_type = get_enemy_type()
	var random_pos = get_random_position()
	var health_handler = enemy_instance.health_handler
	
	enemy_count += 1
	enemy_instance.type = str(enemy_type)

	enemy_instance.global_position = random_pos * terrain_generator.tilesize
	get_parent().add_child(enemy_instance)

func _on_wave_completed():
	print("wave completed")
	cooldown_timer.start(wave_cooldown)
	current_wave += 1

func _on_wave_cooldown_timeout():
	if current_wave <= max_wave_count:
		print(enemy_count)
		start_wave()
		print("wave started")
	else:
		all_waves_finished.emit()

func _on_enemy_died():
	enemy_count -= 1
	if enemy_count == 0:
		wave_completed.emit()
