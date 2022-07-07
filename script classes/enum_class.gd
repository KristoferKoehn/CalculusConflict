extends Node

class_name enums

enum modifier_type {flat, additive}
enum modifier_stat {hull_max, hull_regen, hull_plating, shield_max, shield_regen, shield_plating,
thrust_max, thrust_acceleration, rotate_max, rotate_accel, shot_damage, shot_velocity, bullet_count, 
tracking_magnetism, burst_count, burst_delay, fire_rate, construct_basic_max, construct_max, construct_advanced_max, construct_firerate
construct_hull_max, construct_hull_regen, construct_shield_max, construct_shield_regen, ship_score}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

##default stats for ship, these are gonna be base values to change later.
