extends Node2D



func _ready():
	$CanvasLayer/Control/Blackfade.color = Color("00000000")
	
	
	
	var instance = load("res://Scenes/Entities/Characters/" + Global.class_to_play + "_player.tscn").instantiate()
	
	call_deferred("add_child", instance)
	
	_on_music_finished()
	
	instance.connect("died", game_over)
	
	await instance.ready
	
	start_game()

func start_game():
	$Terrain.start()

func game_over():
	$Music.stop()
	
	await get_tree().create_timer(2).timeout
	
	get_tree().get_first_node_in_group("player").game_ui.dead()
	
	$Death.play()
	$CanvasLayer/Control/TextureRect.show()
	$SpriteShaker.shake()
	
	await get_tree().create_timer(1).timeout
	
	$DeadMusic.play()
	
	var tween = get_tree().create_tween()
	tween.tween_property($CanvasLayer/Control/Blackfade, "color", Color("00000051"), 1)
	
	await tween.finished
	
	print("restart menu")

func _on_music_finished():
	var list = [
		preload("res://Assets/Sounds/BGMusic/Safety Second.ogg"),
		preload("res://Assets/Sounds/BGMusic/Trouble at Shichishito Forest.ogg"),
	]
	
	$Music.stream = list.pick_random()
	
	$Music.play()



func _on_try_again_pressed():
	get_tree().change_scene_to_file("res://Scenes/Root/world.tscn")

func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://UI/main_menu.tscn")


func _on_wave_handler_all_waves_finished():
	Global.won_the_game = true
	get_tree().change_scene_to_file("res://UI/main_menu.tscn")
