extends KinematicBody2D

class_name entity

var stat_manager_scene = load("res://entity/ship_stats/stat_manager.tscn")

var stat_manager = null
var weapon = null

signal damage_taken
signal start_thrust
signal end_thrust
signal fired
signal rotated
signal destroyed


##{hull_max, hull_regen, hull_plating, shield_max, shield_regen, shield_plating,
##thrust_max, thrust_acceleration, rotate_max, rotate_accel, shot_damage, shot_velocity, bullet_count, 
#tracking_magnetism, burst_count, burst_delay, fire_rate, construct_basic_max, construct_max, construct_advanced_max, construct_firerate
##construct_hull_max, construct_hull_regen, construct_shield_max, construct_shield_regen, ship_score}
var stat_block = [100, 5, 0, 50, 4, 0, 600, 15 ,30, 0.7, 5, 1000, 4 ,0,1, 0.2, 0.5, 0,0,0,0,0,0,0,0, 100]

var out_of_bounds = false
var bounds_velocity = Vector2(0,0)
var player_color = Color(1,1,1,1)
var iff_index = -1

var velocity = Vector2(0,0)
var velocity_damping = 1.02
var angular_velocity = 0
var angular_damping = 1.15
var rotate = 0.0

var hull = 100
var shield = 50
var shield_on = true

# === weapon values ===
var shot_speed_timer = .5
var spread_angle = PI * 8/64.0 #RADIANS!!!!


var last_player_damaged = -1

var on_fire = false
var fire_magnitude = 0
var fire_tick_count = 0
var fire_length = 0

func _init():
	stat_manager = stat_manager_scene.instance()
	add_child(stat_manager)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	if hull < 1:
		explode()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	self.rotation += delta * angular_velocity
	angular_velocity = angular_velocity/angular_damping
	velocity = velocity / (1.01 + (velocity.length()/stat_manager.get_stat(enums.modifier_stat.thrust_max)) * 0.02)
	
	var _temp = .move_and_collide(velocity * delta)
	
	if(out_of_bounds):
		bounds_velocity += Vector2(0 - self.global_position.x, 0 - self.global_position.y) * delta
	else:
		bounds_velocity = bounds_velocity/(1000.0)
	velocity += bounds_velocity
	
	if (rotate > 0):
		if self.angular_velocity <= -stat_manager.get_stat(enums.modifier_stat.rotate_max):
			self.angular_velocity = stat_manager.get_stat(enums.modifier_stat.rotate_max)
		else:
			self.angular_velocity += stat_manager.get_stat(enums.modifier_stat.rotate_accel) * rotate
	if (rotate < 0):
		if self.angular_velocity >= stat_manager.get_stat(enums.modifier_stat.rotate_max):
			self.angular_velocity = stat_manager.get_stat(enums.modifier_stat.rotate_max)
		else:
			self.angular_velocity += stat_manager.get_stat(enums.modifier_stat.rotate_accel) * rotate

func apply_damage(incoming_damage, source):
	var adjusted_damage = 0
	emit_signal("damage_taken")
	last_player_damaged = source.iff_index
	if shield_on:
		adjusted_damage = incoming_damage - stat_manager.get_stat(enums.modifier_stat.shield_plating)
		if shield > incoming_damage:
			shield = shield - adjusted_damage
			return adjusted_damage
		else:
			#on spillover damage, both platings applied.
			var total_damage = adjusted_damage - stat_manager.get_stat(enums.modifier_stat.hull_plating)
			adjusted_damage = adjusted_damage - shield - stat_manager.get_stat(enums.modifier_stat.hull_plating)
			hull = hull - adjusted_damage
			return total_damage
	else:
		adjusted_damage = incoming_damage - stat_manager.get_stat(enums.modifier_stat.hull_plating)
		hull = hull - adjusted_damage
		return adjusted_damage

func explode():
	emit_signal("destroyed", last_player_damaged, stat_manager.get_stat(enums.modifier_stat.ship_score))
