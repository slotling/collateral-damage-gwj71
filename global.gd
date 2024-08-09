extends Node

const small_rock_names = [
	"bjornifer",
	"felipe-manuel",
	"henrietta",
	"megarion",
]

const default_data = { # REBOOT EXISTING SAVE FILE EVERYTIME YOU WANT TO CHANGE THE DEFAULT DATA !!!
	"settings":{
		
	},
	"megarion":"is so skibidi",
}

var save_path: String = "user://megarion.anime"
var data: Dictionary = { }

var class_to_play: String = "arsonist"
var won_the_game: bool = false

var operating_system: String = "Android"

func _ready() -> void:
	
	operating_system = OS.get_name()
	
	#reboot_data()
	load_data()

func save_data() -> void: # saves the "data" dict onto the json file that is the save file
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.WRITE)
		file.store_var(data)
		print_rich("[rainbow freq=1.0 sat=0.8 val=0.8]" + str(data) + "[/rainbow]")
		file.close()
		load_data()

func load_data() -> void: # load in the saved data from the save file into the game's "data" dict
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		data = file.get_var()
		print_rich("[rainbow freq=1.0 sat=0.8 val=0.8]" + str(data) + "[/rainbow]")
		file.close()
	else:
		reboot_data()

func reboot_data() -> void: # reverts both the save file's data and the "data" dict to the "default_data" dict
	data = default_data
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.close()
	save_data()

# Utility functions
func add_world_node(instance) -> void:
	get_tree().get_first_node_in_group("main").call_deferred("add_child", instance)

func play_sound(folder:String="", file_name:String="DO NOT OPEN", volumedb:float=0.0, global_position:Vector2=Vector2(-9999, 9999)):
	var audio_stream_player = AudioStreamPlayer.new()
	var audio_stream: AudioStreamOggVorbis = load("res://Assets/Sounds/" + folder + "/" + file_name + ".ogg")
	
	if global_position != Vector2(-9999, 9999):
		audio_stream_player = AudioStreamPlayer2D.new()
		
	
	audio_stream_player.stream = audio_stream
	audio_stream_player.volume_db = volumedb
	
	if "SFX" in folder:
		audio_stream_player.bus = "SFX"
	
	audio_stream_player.connect("finished", audio_stream_player.queue_free)
	
	$AudioPlayers.call_deferred("add_child", audio_stream_player)
	
	audio_stream_player.call_deferred("play")
	
	if global_position != Vector2(-9999, 9999):
		audio_stream_player.call_deferred("set", "global_position", global_position)
