extends Node3D

@onready var controller = get_tree().get_first_node_in_group("Controller")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	var enemy = controller.get_enemy()
	if enemy:
		enemy.show()
		enemy.global_position = global_position
