extends Control



func _on_d_pressed():
	Global.class_to_play = "demolitionist"
	get_tree().change_scene_to_file("res://Scenes/Root/world.tscn")

func _on_a_pressed():
	Global.class_to_play = "arsonist"
	get_tree().change_scene_to_file("res://Scenes/Root/world.tscn")
