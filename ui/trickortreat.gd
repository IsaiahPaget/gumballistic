extends Control

@export var controller: Controller

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_health_button_pressed() -> void:
	controller.trick_or_treat_select('health')


func _on_damage_button_pressed() -> void:
	controller.trick_or_treat_select('damage')


func _on_speed_button_pressed() -> void:
	controller.trick_or_treat_select('speed')


func _on_firerate_button_pressed() -> void:
	controller.trick_or_treat_select('firerate')


func _on_accuracy_button_pressed() -> void:
	controller.trick_or_treat_select('accuracy')


func _on_poise_button_pressed() -> void:
	controller.trick_or_treat_select('poise')


func _on_shot_count_button_pressed() -> void:
	controller.trick_or_treat_select('shot_count')
