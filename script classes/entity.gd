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

var hull = 100
var hull_resistance = 1
var shield = 100
var shield_resistance = 1
var shield_on = true

# === weapon values ===
var burst = 1
var burst_delay = 0.1


var projectiles = 1
var shot_speed_timer = .5
var spread_angle = PI * 8/64.0 #RADIANS!!!!

#builder variables for laser
var laser_damage = 5
var laser_speed = 1000
var laser_tracking = false
var laser_size = 1.0
var laser_pierce = false

# === end weapon values ====


var last_player_damaged = -1

var on_fire = false
var fire_magnitude = 0
var fire_tick_count = 0
var fire_length = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if shield < 1:
		shield_on = false
	else:
		shield_on = true

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


func _on_fire_timeout():
	if fire_tick_count == fire_length:
		get_node("ship/fire_timer").stop()
	else:
		pass
		#put some shit here idk
	
func ignite(magnitude, length, delay):
	if on_fire:
		self.fire_tick_count = 0
	
	self.fire_magnitude = magnitude
	self.fire_length = length
	self.on_fire = true
	get_node("ship/fire_timer").wait_time = delay
	get_node("ship/fire_timer").start()
