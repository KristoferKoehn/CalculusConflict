extends KinematicBody2D

var thrust = 400
var rotation_speed = 15

func _physics_process(delta: float) -> void:
	var velocity = Vector2()
	
	if (Input.is_action_pressed("ui_left")):
		velocity.x = -thrust
	if (Input.is_action_pressed("ui_right")):
		velocity.x = thrust
	if (Input.is_action_pressed("ui_up")):
		velocity.y = -thrust
	if (Input.is_action_pressed("ui_down")):
		velocity.y = thrust
	move_and_collide(velocity * delta)
	
	rotation = 0.1

func _unhandled_key_input(event):
	if (event.is_action_pressed("shoot")):
		$LaserWeapon.shoot()

func get_rotation_vector():
	return Vector2($RotationNode1.global_position.x - $RotationNode2.global_position.x, $RotationNode1.global_position.y - $RotationNode2.global_position.y)
