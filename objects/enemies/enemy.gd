extends CharacterBody3D
class_name Enemy

@onready var player := get_tree().get_first_node_in_group("Player")
@onready var raycast = $RayCast as RayCast3D
@onready var muzzle_a = $MuzzleA
@onready var muzzle_b = $MuzzleB
@onready var nav: NavigationAgent3D = $NavigationAgent3D
@onready var animation := $AnimatedSprite3D
@onready var controller = get_tree().get_first_node_in_group("Controller") as Controller

@export_range(10, 1000) var max_health := 100
@onready var health := max_health
@export var speed := 3

var time := 0.0
var target_position: Vector3
var destroyed := false

var next_nav_point: Vector3
# When ready, save the initial position

func _ready():
	target_position = position

func _process(_delta):
	self.look_at(player.position + Vector3(0, 0.5, 0), Vector3.UP, true)
	velocity = Vector3.ZERO
	nav.set_target_position(player.global_position)
	velocity = (next_nav_point - global_position).normalized() * speed
	move_and_slide()

	if raycast.is_colliding():
		animation.play('attack')
	else:
		animation.play('walk')

# Take damage from player

func damage(amount):
	Audio.play("sounds/enemy/enemy-hurt.ogg")

	self.health -= amount
	
	if float(self.health) / float(max_health) * 100 < 25:	
		self.animation.modulate = Color("Red"); #yellow
	else:if float(self.health) / float(max_health) * 100 < 50:		
		self.animation.modulate = Color("Orange");
	else:if float(self.health) / float(max_health) * 100 < 75:		
		self.animation.modulate = Color("Yellow"); #yellow	
		
		
	if health <= 0 and !destroyed:
		Audio.play("sounds/enemy/enemy-death1.ogg, sounds/enemy/enemy-death2.ogg, sounds/enemy/enemy-death3.ogg, sounds/enemy/enemy-death4.ogg, sounds/enemy/enemy-death5.ogg")
		self.health = max_health
		self.animation.modulate = Color("White");
		controller.return_enemy(self)

	

func navigate():
	next_nav_point = nav.get_next_path_position()

func attack():
	raycast.force_raycast_update()

	if raycast.is_colliding():
		var collider = raycast.get_collider()

		if collider.has_method("damage"):  # Raycast collides with player
			
			# Play muzzle flash animation(s)

			muzzle_a.frame = 0
			muzzle_a.play("default")
			muzzle_a.rotation_degrees.z = randf_range(-45, 45)

			muzzle_b.frame = 0
			muzzle_b.play("default")
			muzzle_b.rotation_degrees.z = randf_range(-45, 45)

			Audio.play("sounds/enemy/enemy-attack.ogg")

			collider.damage(5)  # Apply damage to player
