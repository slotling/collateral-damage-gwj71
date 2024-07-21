extends Control

var in_credits: bool = false

func _ready():
	
	$WIN.hide()
	
	for i in get_tree().get_nodes_in_group("MainMenuButton"):
		i.connect("pressed", button_pressed.bind(str(i.name).to_snake_case()))
	
	if Global.won_the_game:
		$WIN.show()
	
	await get_tree().create_timer(1).timeout
	
	$AnimationPlayer.play("Begin")

func start_music():
	$Music.play()

func instantiate_explosion():
	var instance = preload("res://Scenes/Entities/Projectiles/Variations/demolitionist_self_explosion.tscn").instantiate()
	instance.global_position = $Logo.global_position
	$SpriteShaker.shake()
	call_deferred("add_child", instance)

func button_pressed(which):
	
	if in_credits:
		return
	
	$MenuButton.play()
	
	match which:
		"play":
			get_tree().change_scene_to_file("res://UI/select_player.tscn")
		"credits":
			$AnimationPlayer.play("Credits")
			in_credits = true
		"quit":
			get_tree().quit()
	
	


func _on_back_to_menu_pressed():
	$AnimationPlayer.play("BeginSoft")
	in_credits = false
