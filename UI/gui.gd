extends CanvasLayer

const heh1_preload: AtlasTexture = preload("res://Resources/Atlases/gui_one_third_half_empty_hearts_atlas.tres")
const heh2_preload: AtlasTexture = preload("res://Resources/Atlases/gui_two_thirds_half_empty_hearts_atlas.tres")
const heh3_preload: AtlasTexture = preload("res://Resources/Atlases/gui_half_empty_heart_atlas.tres")
const hearts: AtlasTexture = preload("res://Resources/Atlases/gui_hearts.tres")

@onready var player: Player = get_parent()
@onready var heart_collection: TextureProgressBar = $Control/HBoxContainer/VBoxContainer/Hearts
@onready var heart_shaker: SpriteShaker = $HeartShaker
@onready var stamina_collection: TextureProgressBar = $Control/HBoxContainer/VBoxContainer/Stamina
@onready var stamina_shaker: SpriteShaker = $StaminaShaker
@onready var icon_shaker: SpriteShaker = $IconShaker
@onready var primary_atk_cooldown: ProgressBar = $AttackCooldowns/PrimaryAttackCooldown
@onready var secondary_atk_cooldown: ProgressBar = $AttackCooldowns/SecondaryAttackCooldown

func _ready() -> void:
	pass

func _physics_process(_delta) -> void:
	update_stamina()
	update_cooldowns()

func update_cooldowns() -> void:
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
		stamina_shaker.shake()
	
	if player.state == "dead":
		stamina_collection.value = 0
	else:
		stamina_collection.value = remap(player.movement_handler.stamina, 0, 1000, 0, 96)

func update_hearts(_damage, _cause) -> void:
	heart_shaker.shake()
	icon_shaker.shake()
	heart_collection.value = player.health_handler.health
	
	if heart_collection.value > 90:
		heart_collection.set_progress_texture(hearts)
	elif heart_collection.value > 55:
		heart_collection.set_progress_texture(heh1_preload)
	elif heart_collection.value > 0:
		heart_collection.set_progress_texture(heh2_preload)
	else:
		heart_collection.set_progress_texture(heh3_preload)
	
	# 87, 53, 19
