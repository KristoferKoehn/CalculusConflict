extends Node

var laser_scene = load("res://objects/Laser.tscn")
var player_color = null;

#weapon variables-
var can_shoot = true
var burst_counter = null
 
#specific upgrade variables
func _ready():
	pass

func shoot():
	update_color()
	if can_shoot:
		can_shoot = false
		if get_parent().burst > 1:
			burst_counter = get_parent().burst - 2
			_fire_laser()
			$burst_timer.wait_time = get_parent().burst_delay
			$burst_timer.start()
		else:
			_fire_laser()
			$shot_timer.wait_time = get_parent().shot_speed_timer
			$shot_timer.start()
	else:
		pass

func _fire_laser():
	update_color()
	if get_parent().projectiles > 1:
		var spread_step = get_parent().spread_angle/(1.0 * get_parent().projectiles - 1)
		var spread_start = get_parent().rotation - get_parent().spread_angle/2.0
		for n in range(0, get_parent().projectiles):
			var direction_vector = Vector2(cos((spread_start + (n*spread_step)) + PI/2.0), sin((spread_start + (n *spread_step)) + PI/2.0))
			var laser = laser_scene.instance()
			
			laser.set_direction_vector(direction_vector)
			laser.set_rotation(spread_start + (n*spread_step))
			laser.source = self.get_parent()
			laser.set_speed(get_parent().velocity.length()+get_parent().laser_speed)
			laser.set_color(player_color)
			laser.global_position = get_parent().global_position + direction_vector * -55
			get_node("/root").get_children()[0].add_child(laser)
	else:
		var laser = laser_scene.instance()
		var direction_vector = Vector2(cos(get_parent().rotation + PI/2.0), sin(get_parent().rotation + PI/2.0))
		laser.set_direction_vector(direction_vector)
		laser.set_rotation(get_parent().rotation)
		laser.set_speed(get_parent().velocity.length()+get_parent().laser_speed)
		laser.set_color(player_color)
		laser.global_position = get_parent().global_position + direction_vector * -55
		laser.source = self.get_parent()
		get_node("/root").get_children()[0].add_child(laser)

func _on_Timer_timeout():
	can_shoot = true
 
func update_color():
	player_color = get_parent().player_color

func _on_burst_timer_timeout():
	_fire_laser()
	if burst_counter > 0:
		burst_counter = burst_counter - 1
		$burst_timer.wait_time = get_parent().burst_delay
		$burst_timer.start()
	else:
		$shot_timer.wait_time = get_parent().shot_speed_timer
		$shot_timer.start()
