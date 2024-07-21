extends CanvasLayer

const heh1_preload: AtlasTexture = preload("res://Resources/Atlases/gui_one_third_half_empty_hearts_atlas.tres")
const heh2_preload: AtlasTexture = preload("res://Resources/Atlases/gui_two_thirds_half_empty_hearts_atlas.tres")
const heh3_preload: AtlasTexture = preload("res://Resources/Atlases/gui_half_empty_heart_atlas.tres")
const hearts: AtlasTexture = preload("res://Resources/Atlases/gui_hearts.tres")

const emotions = {
	"default":0,
	"negative":1,
	"positive":2,
	"focused":3,
	"dead":4,
}

@onready var player: Player = get_parent()
@onready var heart_collection: TextureProgressBar = $Control/HBoxContainer/VBoxContainer/Hearts
@onready var heart_shaker: SpriteShaker = $HeartShaker
@onready var stamina_collection: TextureProgressBar = $Control/HBoxContainer/VBoxContainer/Stamina
@onready var stamina_shaker: SpriteShaker = $StaminaShaker
@onready var icon_shaker: SpriteShaker = $IconShaker
@onready var primary_atk_cooldown: ProgressBar = $AttackCooldowns/PrimaryAttackCooldown
@onready var secondary_atk_cooldown: ProgressBar = $AttackCooldowns/SecondaryAttackCooldown
@onready var emotion_timer: Timer = $EmotionTimer
@onready var icon: Sprite2D = $Control/HBoxContainer/IconBase/Icon

func _ready() -> void:
	await player.ready
	player.health_handler.connect("hit", player_hit)

func _physics_process(_delta) -> void:
	update_stamina()
	update_cooldowns()
	update_hearts()

func update_cooldowns() -> void:
	
	if player.state == "dead":
		primary_atk_cooldown.modulate = Color("black")
		secondary_atk_cooldown.modulate = Color("black")
		return
	
	var primary_cdt: Timer = player.primary_attack.cooldown_timer
	var secondary_cdt: Timer = player.secondary_attack.cooldown_timer
	var primary_modulate_remap: float = remap(primary_cdt.time_left, 0, primary_cdt.wait_time, 1.0, 0.0)
	var secondary_modulate_remap: float = remap(secondary_cdt.time_left, 0, secondary_cdt.wait_time, 1.0, 0.0)
	primary_atk_cooldown.value = remap(primary_cdt.time_left, 0, primary_cdt.wait_time, 64, 0)
	primary_atk_cooldown.modulate = Color(primary_modulate_remap, primary_modulate_remap, primary_modulate_remap, 1.0)
	secondary_atk_cooldown.value = remap(secondary_cdt.time_left, 0, secondary_cdt.wait_time, 64, 0)
	secondary_atk_cooldown.modulate = Color(secondary_modulate_remap, secondary_modulate_remap, secondary_modulate_remap, 1.0)

func update_stamina() -> void:
	if player.movement_handler.running and player.state == "walk":
		change_emotion("focused", 0.1, "focused")
		stamina_shaker.shake()
	else:
		change_emotion("default", 0.1)
	
	if player.state == "dead":
		change_emotion("dead", 0.1, "dead", true)
		stamina_collection.value = 0
	else:
		stamina_collection.value = remap(player.movement_handler.stamina, 0, 1000, 0, 96)

func update_hearts() -> void:
	if player.health_handler.health == 0:
		heart_collection.value = 0
	else:
		heart_collection.value = lerp(heart_collection.value, float(player.health_handler.health), 0.1)
	
	if heart_collection.value > 90:
		heart_collection.set_progress_texture(hearts)
	elif heart_collection.value > 55:
		heart_collection.set_progress_texture(heh1_preload)
	elif heart_collection.value > 22:
		heart_collection.set_progress_texture(heh2_preload)
	else:
		heart_collection.set_progress_texture(heh3_preload)
	
	# 87, 53, 19

func change_emotion(emotion_name:String="default", time:float=0.4, revert_to:String="default", override:bool=false) -> void:
	if emotion_timer.is_connected("timeout", icon.set_frame.bind(emotions[revert_to])):
		if !override:
			return
		emotion_timer.disconnect("timeout", icon.set_frame.bind(emotions[revert_to]))
	
	icon.frame = emotions[emotion_name]
	
	emotion_timer.connect("timeout", icon.set_frame.bind(emotions[revert_to]), 4)
	emotion_timer.start(time)

func player_hit(value, cause, hurtbox_global_position) -> void:
	change_emotion("negative", 0.4, "default", true)
