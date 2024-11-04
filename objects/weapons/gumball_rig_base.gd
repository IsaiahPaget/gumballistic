extends Node3D
@onready var animTree := $gumball_AnimationTree as AnimationTree

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func shoot():
	animTree.set("parameters/OneShot/active", true)
