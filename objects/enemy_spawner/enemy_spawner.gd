extends Node3D

@onready var controller = get_tree().get_first_node_in_group("Controller")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	$Timer.wait_time = randf_range(0.5, 1)
	var enemy = controller.get_enemy()
	if enemy:
		Audio.play("sounds/enemy/enemy-spawn.ogg")
		enemy.show()
		if not controller.enemy_attack.is_connected(enemy.attack):
			controller.enemy_attack.connect(enemy.attack)
		if not controller.enemy_nav.is_connected(enemy.navigate):
			controller.enemy_nav.connect(enemy.navigate)
		enemy.global_position = global_position
