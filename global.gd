extends Node

const default_data = { # REBOOT EXISTING SAVE FILE EVERYTIME YOU WANT TO CHANGE THE DEFAULT DATA !!!
	"settings":{
		
	},
	"megarion":"is so skibidi",
}

var save_path: String = "user://megarion.anime"
var data: Dictionary = { }



func _ready():
	#reboot_data()
	load_data()

func save_data(): # saves the "data" dict onto the json file that is the save file
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.WRITE)
		file.store_var(data)
		print_rich("[rainbow freq=1.0 sat=0.8 val=0.8]" + str(data) + "[/rainbow]\n[img=160x160]res://UI/megarion.jpg[/img]")
		file.close()
		load_data()

func load_data(): # load in the saved data from the save file into the game's "data" dict
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		data = file.get_var()
		print_rich("[rainbow freq=1.0 sat=0.8 val=0.8]" + str(data) + "[/rainbow]\n[img=160x160]res://UI/megarion.jpg[/img]")
		file.close()
	else:
		reboot_data()

func reboot_data(): # reverts both the save file's data and the "data" dict to the "default_data" dict
	data = default_data
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.close()
	save_data()

# Utility functions
func add_world_node(instance):
	get_tree().get_root().add_child(instance)
