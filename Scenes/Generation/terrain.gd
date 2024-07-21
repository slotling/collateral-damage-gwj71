extends Node2D

const bambooPreload = preload("res://Scenes/Environment/bamboo.tscn")
const toriiPreload = preload("res://Scenes/Environment/torii_gate.tscn")
const small_rockPreload = preload("res://Scenes/Environment/small_rock.tscn")
const big_rockPreload = preload("res://Scenes/Environment/big_rock.tscn")

@export var debugNoRelocate = false
@export var size:Vector2 = Vector2.ZERO
@export var border_width:int = 20

@export var bamboo_scarcity_chance: int = 15
@export var torii_scarcity_chance: int = 200
@export var small_rock_scarcity_chance: int = 50
@export var big_rock_scarcity_chance: int = 120

@export var noise_map : NoiseTexture2D
var noise : Noise
@onready var color_ramp : Gradient = noise_map.color_ramp
@onready var color_ramp_offsets : Array = noise_map.color_ramp.offsets

@onready var navigation: NavigationRegion2D = $NavigationRegion2D
@onready var tilemap: TileMap = $NavigationRegion2D/TileMap
@onready var tileset: TileSet = tilemap.tile_set
@onready var tilesize: Vector2 = tileset.tile_size

const tile_source = [
	0, # no collide water
	4, # water tile
	5, # dirt tile
	3, # grass tile
]
const tile_atlas_coords = [
	Vector2(0, 0),
	Vector2(0, 0),
	Vector2(0, 0),
	Vector2(3, 7),
]

func _ready():
	randomize()
	noise_map.noise.seed = randi()
	noise = noise_map.noise
	generate_initial()
	generate()
	make_and_bake_navigation()

func relocate_player(x, y):
	var target = get_tree().get_first_node_in_group("player")
	if !debugNoRelocate:
		target.global_position = Vector2(x-size.x/2, y-size.y/2)*tilesize

var spawnable_tiles = []
func generate():
	spawnable_tiles = []
	var noise_value_array:Array = []
	var noise_value_array_flattened:Array = []
	
	for x in range(size.x):
		noise_value_array.append([])
		for y in range(size.y):
			var noise_value = noise.get_noise_2dv(Vector2(x, y))
			noise_value_array[x].append(noise_value)
			noise_value_array_flattened.append(noise_value)

	var max_val:float = noise_value_array_flattened.max()
	var min_val:float = noise_value_array_flattened.min()

	for x in range(size.x):
		for y in range(size.y):
			var noise_value_decimal = (noise_value_array[x][y] - min_val) / (max_val-min_val)
			if noise_value_decimal >= 0.6:
				spawnable_tiles.append(Vector2(x, y))
			
			for i in range(color_ramp_offsets.size()):
				if noise_value_decimal <= color_ramp_offsets[i]:
					generate_tile(i-1, x, y)
					break
	
	var random_spawnable_tile_pos = spawnable_tiles.pick_random()
	relocate_player(random_spawnable_tile_pos.x, random_spawnable_tile_pos.y)

func generate_initial():
	for x in range(size.x+border_width*2):
		for y in range(size.y+border_width*2):
			generate_tile(0, x-border_width, y-border_width)
			
	for x in range(size.x+2):
		for y in range(size.y+2):
			generate_tile(1, x-1, y-1)

var navigation_vertices = []



func spawn_chance(preloaded_scene, scarcity_chance, global_pos):
	if randi_range(0, scarcity_chance) == 0:
		var instance = preloaded_scene.instantiate()
		instance.global_position = global_pos
		Global.add_world_node(instance)

func generate_tile(value, x, y):
	var tilepos = Vector2(x-size.x/2, y-size.y/2)
	tilemap.set_cell(0, tilepos, tile_source[value], tile_atlas_coords[value])
	
	match value:
		0: # no collide water tile
			pass
		1: # water tile
			pass
		2: # dirt tile
			spawn_chance(bambooPreload, bamboo_scarcity_chance, tilepos*tilesize)
			
			spawn_chance(small_rockPreload, small_rock_scarcity_chance, tilepos*tilesize)
			
		3: # grass tile
			spawn_chance(toriiPreload, torii_scarcity_chance, tilepos*tilesize)
			
			spawn_chance(small_rockPreload, small_rock_scarcity_chance, tilepos*tilesize)
			
			spawn_chance(big_rockPreload, big_rock_scarcity_chance, tilepos*tilesize)

func make_and_bake_navigation():
	var new_navigation_mesh = NavigationPolygon.new()
	var x_bound:float = size.x/2*tilesize.x
	var y_bound = size.y/2*tilesize.y
	var bounding_outline = PackedVector2Array([
		Vector2(x_bound, y_bound), 
		Vector2(x_bound, -y_bound), 
		Vector2(-x_bound, -y_bound), 
		Vector2(-x_bound, y_bound), 
	])
	new_navigation_mesh.add_outline(bounding_outline)
	navigation.navigation_polygon = new_navigation_mesh
	navigation.bake_navigation_polygon()

