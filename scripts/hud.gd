extends CanvasLayer

@export var health_bar: Control
@export var firerate_label: Label
@export var poise_label: Label
@export var damage_label: Label
@export var accuracy_label: Label
@export var speed_label: Label
@export var shotcount_label: Label
@export var kills_label: Label

# Old value placeholders
var _old_firerate = 0
var _old_poise = 0
var _old_damage = 0
var _old_spread = 0
var _old_speed = 0
var _old_shotcount = 0

# Event handler for health updates
func _on_health_updated(health):
	health_bar.set_health(health)


func _on_player_speed_updated(speed) -> void:
	if speed > _old_speed:
		speed_label.text = "speed: " + str(speed)
		speed_label.add_theme_color_override("font_color", Color(0, 1, 0))  # Green
	elif speed == _old_speed:
		speed_label.text = "speed: " + str(speed)
		speed_label.add_theme_color_override("font_color", Color(1, 1, 1))  # White
	else:
		speed_label.text = "speed: " + str(speed)
		speed_label.add_theme_color_override("font_color", Color(1, 0, 0))  # Red

	# Update the old speed and return it
	_old_speed = speed

func _on_player_shotcount_updated(shotcount) -> void:
	if shotcount > _old_shotcount:
		shotcount_label.text = "shotcount: " + str(shotcount)
		shotcount_label.add_theme_color_override("font_color", Color(0, 1, 0))  # Green
	elif shotcount == _old_shotcount:
		shotcount_label.text = "shotcount: " + str(shotcount)
		shotcount_label.add_theme_color_override("font_color", Color(1, 1, 1))  # White
	else:
		shotcount_label.text = "shotcount: " + str(shotcount)
		shotcount_label.add_theme_color_override("font_color", Color(1, 0, 0))  # Red

	# Update the old shotcount and return it
	_old_shotcount = shotcount


func _on_player_poise_updated(poise) -> void:
	if poise > _old_poise:
		poise_label.text = "poise: " + str(poise)
		poise_label.add_theme_color_override("font_color", Color(0, 1, 0))  # Green
	elif poise == _old_poise:
		poise_label.text = "poise: " + str(poise)
		poise_label.add_theme_color_override("font_color", Color(1, 1, 1))  # White
	else:
		poise_label.text = "poise: " + str(poise)
		poise_label.add_theme_color_override("font_color", Color(1, 0, 0))  # Red

	# Update the old poise and return it
	_old_poise = poise


func _on_player_firerate_updated(firerate) -> void:
	if firerate < _old_firerate:
		firerate_label.text = "firerate: " + str(firerate)
		firerate_label.add_theme_color_override("font_color", Color(0, 1, 0))  # Green
	elif firerate == _old_firerate:
		firerate_label.text = "firerate: " + str(firerate)
		firerate_label.add_theme_color_override("font_color", Color(1, 1, 1))  # White
	else:
		firerate_label.text = "firerate: " + str(firerate)
		firerate_label.add_theme_color_override("font_color", Color(1, 0, 0))  # Red

	# Update the old firerate and return it
	_old_firerate = firerate


func _on_player_damage_updated(damage) -> void:
	if damage > _old_damage:
		damage_label.text = "damage: " + str(damage)
		damage_label.add_theme_color_override("font_color", Color(0, 1, 0))  # Green
	elif damage == _old_damage:
		damage_label.text = "damage: " + str(damage)
		damage_label.add_theme_color_override("font_color", Color(1, 1, 1))  # White
	else:
		damage_label.text = "damage: " + str(damage)
		damage_label.add_theme_color_override("font_color", Color(1, 0, 0))  # Red

	# Update the old damage and return it
	_old_damage = damage

func _on_player_accuracy_updated(spread) -> void:
	if spread < _old_spread:
		accuracy_label.text = "spread: " + str(spread)
		accuracy_label.add_theme_color_override("font_color", Color(0, 1, 0))  # Green
	elif spread == _old_spread:
		accuracy_label.text = "spread: " + str(spread)
		accuracy_label.add_theme_color_override("font_color", Color(1, 1, 1))  # White
	else:
		accuracy_label.text = "spread: " + str(spread)
		accuracy_label.add_theme_color_override("font_color", Color(1, 0, 0))  # Red

	# Update the old spread and return it
	_old_spread = spread


func _on_controller_enemy_killed(kills) -> void:
	kills_label.text = "Kills: " + str(kills)
