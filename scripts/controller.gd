extends Node
class_name Controller

@export var spook_scn: PackedScene
@export var speedy_scn: PackedScene
@export var heavy_scn: PackedScene
@export var fairy_scn: PackedScene
var _enemies := []
var level = 1
var _kills = 0
@export var max_enemies = 5

var _enemies_in_game := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if not _enemies_in_game >= max_enemies and _kills < max_enemies:
		var enemy := spook_scn.instantiate() as Enemy
		add_child(enemy)
		enemy.hide()
		_enemies.push_front(enemy)
		_enemies_in_game += 1
	if _kills >= len(_enemies):
		level += 1

func get_enemy() -> Enemy:
	return _enemies.pop_back()

func return_enemy(enemy: Enemy) -> void:
	_kills += 1
	enemy.hide()
	_enemies.push_front(enemy)
