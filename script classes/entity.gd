extends KinematicBody2D

class_name entity

var out_of_bounds = false
var bounds_velocity = Vector2(0,0)
var player_color = null

var max_thrust = 600
var velocity = Vector2(0,0)
var velocity_damping = 1.02
var acceleration = 15
var rotation_speed = .8
var rotation_max = 60
var angular_velocity = 0
var angular_damping = 1.15

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	self.rotation += delta * angular_velocity
	angular_velocity = angular_velocity/angular_damping
	velocity = velocity / (1.01 + (velocity.length()/max_thrust) * 0.02)
	
	var _temp = .move_and_collide(velocity * delta)
	
	if(out_of_bounds):
		bounds_velocity += Vector2(0 - self.global_position.x, 0 - self.global_position.y) * delta
	else:
		bounds_velocity = bounds_velocity/(1000.0)
	velocity += bounds_velocity
