extends Node

const default_data = { # REBOOT EXISTING SAVE FILE EVERYTIME YOU WANT TO CHANGE THE DEFAULT DATA !!!
	"settings":{
		
	}
}

var save_path: String = "user://megarion.anime"
var data: Dictionary = { }

func _ready():
	#reboot_data()
	load_data()

func save_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.WRITE)
		file.store_var(data)
		print(data)
		file.close()
		load_data()

func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		data = file.get_var()
		print(data)
		file.close()
	else:
		reboot_data()

func reboot_data():
	data = default_data
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.close()
	save_data()
