extends Node
class_name Controller

@export var spook_scn: PackedScene
@export var speedy_scn: PackedScene
@export var heavy_scn: PackedScene
@export var fairy_scn: PackedScene
@export var trick_or_treat: Control
@onready var player = get_tree().get_first_node_in_group("Player")

var _enemies := []
@onready var _banes := [
	player.degrade_health,
	player.degrade_firerate,
	player.degrade_poise,
	player.degrade_speed,
	player.degrade_damage,
	player.degrade_shot_count,
	player.degrade_accuracy,
]
var level = 1
var _kills = 0
@export var max_enemies = 5

var _enemies_in_game := 0
var _is_looking_at_menu := false

signal trick_or_treat_selection_made
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if _enemies_in_game < max_enemies:
		var enemy := spook_scn.instantiate() as Enemy
		add_child(enemy)
		enemy.hide()
		_enemies.push_front(enemy)
		_enemies_in_game += 1

	if _kills >= max_enemies and not _is_looking_at_menu:
		_is_looking_at_menu = true
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
	return _enemies.pop_back()

func return_enemy(enemy: Enemy) -> void:
	_kills += 1
	enemy.hide()
	_enemies.push_front(enemy)

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

	var rand_index = randi() % _banes.size()	
	_banes[rand_index].call()
	trick_or_treat_selection_made.emit()
	_is_looking_at_menu = false
	player.update_ui_stats()
