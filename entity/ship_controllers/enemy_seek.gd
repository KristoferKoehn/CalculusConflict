extends Node

var ship = null
var iff_index = 7
var targets = []
var closest = null
# Called when the node enters the scene tree for the first time.
func _ready():
	ship = get_node("ship")
	ship.update_colors(Color(1.2,0,0,1))
	set_hostility_index(7)

func set_hostility_index(index):
	ship.iff_index = index
	iff_index = index

func _on_Area2D_body_entered(body):
	if body.is_in_group("player") && body != ship:
		targets.append(body)

func _on_Area2D_body_exited(body):
	if targets.has(body):
		targets.erase(body)

func _process(delta):
	
	self.get_node("Area2D").global_position = ship.global_position

	if targets.size() > 0:
		closest = targets[0]
		for i in range(1, len(targets)):
			if ship.global_position.distance_to(targets[i].global_position) < ship.global_position.distance_to(closest.global_position):
				closest = targets[i]
		var T = ship.global_position.angle_to_point(closest.global_position) 
		var C = ship.rotation + PI/2.0
		var angle_difference = fmod((T - C + (3.0 * PI)), 2.0*PI) - PI
		if angle_difference  > 0.02:
			ship.rotate_left()
		elif angle_difference < -0.02:
			ship.rotate_right()
		else:
			ship.end_rotate()
			if ship.global_position.distance_to(closest.global_position) > 400:
				ship.thrust()
				ship.end_shoot()
			else: 
				ship.end_thrust()
				ship.shoot()
	else: 
		ship.end_thrust()
		ship.end_rotate()
		pass
