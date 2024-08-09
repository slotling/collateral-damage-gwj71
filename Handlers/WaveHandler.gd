extends Node

signal wave_completed
signal all_waves_finished
signal enemy_died

@onready var cooldown_timer = $WaveCooldown
@onready var terrain_generator: Node2D = get_tree().get_first_node_in_group("terrain_generator")
var enemy_preload = [
	preload("res://Scenes/Entities/Enemies/terminator_enemy.tscn"),
	preload("res://Scenes/Entities/Enemies/panda_enemy.tscn"),
	preload("res://Scenes/Entities/Enemies/car_enemy.tscn"),
]
@export var enabled = true

@export var wave_cooldown: int

var wave_layout = [
	#[3, 0, 0],
	#[5, 0, 0],
	#[5, 0, 0],
	#[8, 0, 0],
	#[10, 0, 0],
	#[10, 1, 0],
	#[12, 1, 0],
	[12, 1, 0],
	[12, 2, 0],
	[0, 0, 1],
	[1, 0, 0],
]

var enemy_count: int = 0
var current_wave: int = 0

func _ready():
	randomize()

func start_wave():
	if !enabled:
		return
	
	var enemies_to_add = wave_layout[current_wave]
	enemy_count = 0
	for i in range(enemies_to_add.size()):
		enemy_count += enemies_to_add[i]
		for n in range(enemies_to_add[i]):
			spawn_enemy(enemy_preload[i])
			await get_tree().create_timer(1).timeout

func get_random_position(): 
	if terrain_generator:
		var spawnable_tiles = terrain_generator.spawnable_tiles
		var random_tile_pos = spawnable_tiles.pick_random()
		return random_tile_pos - terrain_generator.size/2
	return Vector2.ZERO

func _process(delta):
	if current_wave == wave_layout.size() - 1:
		if get_tree().get_nodes_in_group("enemy"):
			all_waves_finished.emit()

func spawn_enemy(enemy):
	var enemy_instance = enemy.instantiate()
	var random_pos = get_random_position()
	var health_handler = enemy_instance.health_handler
	enemy_instance.global_position = random_pos * terrain_generator.tilesize
	get_parent().add_child(enemy_instance)

func _on_wave_completed():
	print("wave completed")
	
	cooldown_timer.start(wave_cooldown)
	current_wave += 1

func _on_wave_cooldown_timeout():
	if current_wave != wave_layout.size():
		start_wave()
		print("wave started")

func _on_enemy_died():
	enemy_count -= 1
	if enemy_count == 0:
		wave_completed.emit()
		
		
