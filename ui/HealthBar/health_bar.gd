extends Control
class_name HealthBar

@onready var timer: Timer = $Timer
@onready var damage_bar: ProgressBar = $Fill/Damage
@onready var fill_bar: ProgressBar = $Fill

var max_health: int = 100
var health: int = max_health

func _ready():
	reset_health(health)

func _on_timer_timeout() -> void:
	damage_bar.value = health


func set_health(_health: int):
	if timer and damage_bar and fill_bar:
		var prv_health = health
		if _health > fill_bar.max_value:
			reset_health(_health)
			return

		health = min(fill_bar.max_value, _health)

		fill_bar.value = health
		if health <= 0:
			queue_free()

		if health < prv_health:
			timer.start()
		else:
			damage_bar.value = health


func reset_health(_health: int):
	health = _health
	max_health = health
	fill_bar.value = health
	fill_bar.max_value = health
	damage_bar.value = health
	damage_bar.max_value = health
	
