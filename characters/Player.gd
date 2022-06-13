extends KinematicBody2D

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

var shooting = false

func _ready():
	player_color = get_node("/root/Game").player_colors[0]
	$Sprite.modulate = player_color
	$EngineParticles.update_color()
	$LaserWeapon.update_color()

func _process(_delta):
	if shooting:
		$LaserWeapon.shoot()
	else:
		pass

func _physics_process(delta: float) -> void:
	
	if (Input.is_action_pressed("shoot")):
		shooting = true
	else:
		shooting = false

	if (Input.is_action_pressed("turn_left")):
		if self.angular_velocity <= -rotation_max:
			self.angular_velocity = rotation_max
		else:
			self.angular_velocity -= rotation_speed
		
	if (Input.is_action_pressed("turn_right")):
		if self.angular_velocity >= rotation_max:
			self.angular_velocity = rotation_max
		else:
			self.angular_velocity += rotation_speed
	if (Input.is_action_pressed("thrust")):
		velocity += Vector2(cos(self.rotation - PI/2.0), sin(self.rotation - PI/2.0)) * acceleration
		$EngineParticles.emitting = true
		if !$EngineNoise.playing:
			$EngineNoise.play()
	else:
		$EngineNoise.stop()
		$EngineParticles.emitting = false
	rotation += delta * angular_velocity
	angular_velocity = angular_velocity/angular_damping
	velocity = velocity / (1.01 + (velocity.length()/max_thrust) * 0.02)
	
	
	var _temp = move_and_collide(velocity * delta)
	
	if(out_of_bounds):
		bounds_velocity += Vector2(0 - self.global_position.x, 0 - self.global_position.y) * delta
	else:
		bounds_velocity = bounds_velocity/(1000.0)
	velocity += bounds_velocity
