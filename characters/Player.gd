extends KinematicBody2D

var max_thrust = 400
var velocity = Vector2(0,0)
var velocity_damping = 1.02
var acceleration = 15
var rotation_speed = .9
var rotation_max = 60
var angular_velocity = 0
var angular_damping = 1.15

func _physics_process(delta: float) -> void:

	if (Input.is_action_pressed("ui_left")):
		if self.angular_velocity <= -rotation_max:
			self.angular_velocity = rotation_max
		else:
			self.angular_velocity -= rotation_speed
		
	if (Input.is_action_pressed("ui_right")):
		if self.angular_velocity >= rotation_max:
			self.angular_velocity = rotation_max
		else:
			self.angular_velocity += rotation_speed
	if (Input.is_action_pressed("ui_up")):
		if velocity.length() >= max_thrust:
			velocity = velocity.normalized() * max_thrust
		else:
			velocity += self.get_rotation_vector() * acceleration
	
	rotation += delta * angular_velocity
	angular_velocity = angular_velocity/angular_damping
	velocity = velocity / velocity_damping
	move_and_collide(velocity * delta)

func _unhandled_key_input(event):
	if (event.is_action_pressed("shoot")):
		$LaserWeapon.shoot()

func get_rotation_vector():
	return Vector2($RotationNode2.global_position.x - $RotationNode1.global_position.x, $RotationNode2.global_position.y - $RotationNode1.global_position.y)
