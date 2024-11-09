extends Node
class_name Controller

@export var spook_scn: PackedScene
@export var super_scn: PackedScene
@export var sturdy_scn: PackedScene
@export var sprite_scn: PackedScene
@export var trick_or_treat: Control

@onready var player := get_tree().get_first_node_in_group("Player") as Player
@onready var enemy_scenes := [spook_scn, super_scn, sprite_scn, sturdy_scn]

var _enemies := []
var level = 1
var _kills = 0
var _total_kills := 0 
@export var max_enemies = 5

var _enemies_in_game := 0
var _is_looking_at_menu := false
var _enemies_in_play := 0

signal trick_or_treat_selection_made
signal enemy_attack
signal enemy_nav
signal enemy_killed
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Audio.play("sounds/player/heartbeat.ogg")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if _enemies_in_game < max_enemies:
		var rand_index = randi() % enemy_scenes.size()
		var scn = enemy_scenes[rand_index]
		var enemy := scn.instantiate() as Enemy
		add_child(enemy)
		enemy.hide()
		_enemies.push_front(enemy)
		_enemies_in_game += 1

	if _kills >= max_enemies and not _is_looking_at_menu:
		open_treat_menu()

func open_treat_menu():
		_is_looking_at_menu = true
		player.in_menu = true
		level += 1
		Engine.time_scale = 0
		trick_or_treat.show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		await trick_or_treat_selection_made
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		trick_or_treat.hide()
		Engine.time_scale = 1
		_kills = 0
		max_enemies += 1

func get_enemy() -> Enemy:
	if not _enemies_in_play < max_enemies:
		return
	return _enemies.pop_back()

func return_enemy(enemy: Enemy) -> void:
	_kills += 1
	_total_kills += 1
	if enemy_attack.is_connected(enemy.attack):
		enemy_attack.disconnect(enemy.attack)
	if enemy_nav.is_connected(enemy.navigate):
		enemy_nav.disconnect(enemy.navigate)
	enemy.hide()
	_enemies.push_front(enemy)
	enemy_killed.emit(_total_kills)

func trick_or_treat_select(selection: String) -> void:
	match selection.to_lower():
		'health':
			player.upgrade_health()
		'damage':
			player.upgrade_damage()
		'speed':
			player.upgrade_speed()
		'firerate':
			player.upgrade_firerate()
		'accuracy':
			player.upgrade_accuracy()
		'poise':
			player.upgrade_poise()
		'shot_count':
			player.upgrade_shot_count()

	trick_or_treat_selection_made.emit()
	_is_looking_at_menu = false
	player.in_menu = false
	player.update_ui_stats()


func _on_nav_timer_timeout() -> void:
	enemy_nav.emit()


func _on_attack_timer_timeout() -> void:
	enemy_attack.emit()


