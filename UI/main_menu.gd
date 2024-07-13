extends Control



func _ready():
	
	for i in get_tree().get_nodes_in_group("MainMenuButton"):
		i.connect("pressed", button_pressed.bind(str(i.name).to_snake_case()))



func button_pressed(which):
	match which:
		"play":
			pass
		"settings":
			pass
		"credits":
			pass
		"quit":
			get_tree().quit()
