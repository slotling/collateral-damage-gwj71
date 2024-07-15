extends Node2D

@export var size:Vector2 = Vector2.ZERO

@export var noise_map : NoiseTexture2D
@onready var noise : Noise = noise_map.noise
@onready var color_ramp : Gradient = noise_map.color_ramp
@onready var color_ramp_offsets : Array = noise_map.color_ramp.offsets

@onready var tilemap: TileMap = $TileMap
const tile_source = [
	0,
	1
]
const tile_atlas_coords = [
	Vector2(0, 0),
	Vector2(0, 0)
]

func generate():
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
			
			for i in range(color_ramp_offsets.size()):
				if noise_value_decimal <= color_ramp_offsets[i]:
					generate_tile(i-1, x, y)
					break

func generate_tile(value, x, y):
	tilemap.set_cell(0, Vector2(x-size.x/2, y-size.y/2), tile_source[value], tile_atlas_coords[value])

func _ready():
	generate()

func _process(delta):
	pass
