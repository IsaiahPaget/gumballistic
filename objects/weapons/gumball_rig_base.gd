extends Node3D

@onready var player := get_tree().get_first_node_in_group("Player")
@onready var animTree := $gumball_AnimationTree as AnimationTree

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func shoot():
	animTree.set('parameters/OneShot/request', true)
	
func anim_idle_speed(float):
	animTree.set("parameters/IdleLoopTimeScale/scale", float)
