extends Node

var laser_scene = load("res://objects/Laser.tscn")
var player_color = null;

#weapon variables-
var can_shoot = true
var burst = 1
var burst_delay = 0.1
var burst_counter = null

var projectiles = 1
var shot_speed_timer = .5
var spread_angle = PI * 8/64.0 #RADIANS!!!!

#builder variables for laser
var laser_damage = 5
var laser_speed = 1000
var laser_tracking = false
var laser_size = 1.0
var laser_pierce = false
 
#specific upgrade variables
func _ready():
	pass

func shoot():
	if can_shoot:
		can_shoot = false
		if burst > 1:
			burst_counter = burst - 2
			_fire_laser()
			$burst_timer.wait_time = burst_delay
			$burst_timer.start()
		else:
			_fire_laser()
			$shot_timer.wait_time = shot_speed_timer
			$shot_timer.start()
	else:
		pass

func _fire_laser():
	if projectiles > 1:
		var spread_step = spread_angle/(1.0 * projectiles - 1)
		var spread_start = get_parent().rotation - spread_angle/2.0
		for n in range(0, projectiles):
			var direction_vector = Vector2(cos((spread_start + (n*spread_step)) + PI/2.0), sin((spread_start + (n *spread_step)) + PI/2.0))
			var laser = laser_scene.instance()
			
			laser.set_direction_vector(direction_vector)
			laser.set_rotation(spread_start + (n*spread_step))
			
			laser.set_speed(get_parent().velocity.length()+laser_speed)
			laser.set_color(player_color)
			laser.global_position = get_parent().global_position + direction_vector * -55
			get_node("/root").get_children()[0].add_child(laser)
	else:
		var laser = laser_scene.instance()
		var direction_vector = Vector2(cos(get_parent().rotation + PI/2.0), sin(get_parent().rotation + PI/2.0))
		laser.set_direction_vector(direction_vector)
		laser.set_rotation(get_parent().rotation)
		laser.set_speed(get_parent().velocity.length()+laser_speed)
		laser.set_color(player_color)
		laser.global_position = get_parent().global_position + direction_vector * -55
		get_node("/root").get_children()[0].add_child(laser)

func _on_Timer_timeout():
	can_shoot = true
 
func update_color():
	player_color = get_parent().player_color

func _on_burst_timer_timeout():
	_fire_laser()
	if burst_counter > 0:
		burst_counter = burst_counter - 1
		$burst_timer.wait_time = burst_delay
		$burst_timer.start()
	else:
		$shot_timer.wait_time = shot_speed_timer
		$shot_timer.start()
