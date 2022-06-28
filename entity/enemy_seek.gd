extends Node2D

var ship = null
var team = -1
var targets = []
var closest = null
var counter = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	ship = get_node("ship")

func _on_Area2D_body_entered(body):
	if body.is_in_group("player") && body != ship:
		targets.append(body)

func _on_Area2D_body_exited(body):
	if targets.has(body):
		targets.remove(body)

func _process(delta):
	
	counter += 1
	
	
	if len(targets) < 1:
		pass

	closest = targets[0]
	for i in range(1, len(targets)):
		if ship.global_position.distance_to(targets[i].global_position) < ship.global_position.distance_to(closest.global_position):
			closest = targets[i]

	if closest != null:
		#ship.look_at(closest.global_position)

		var T = ship.global_position.angle_to_point(closest.global_position) 
		var C = ship.rotation - PI/2.0
		var angle_difference = fmod((T - C + 3.0 * PI), 2.0*PI - PI)
		if angle_difference  > 0.3:
			ship.rotate_left()
		elif angle_difference < -0.3:
			ship.rotate_right()
		else:
			ship.end_rotate()
