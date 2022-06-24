extends Node2D

var ship = null
var team = -1
var targets = []
var closest = null

# Called when the node enters the scene tree for the first time.
func _ready():
	ship = get_node("ship")

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		targets.append(body)

func _on_Area2D_body_exited(body):
	targets.remove(body)

func _process(delta):
	if len(targets) < 1:
		pass

	closest = targets[0]
	for i in range(1, len(targets)):
		if self.position.distance_to(targets[i]) < self.position.distance_to(closest):
			closest = targets[i]
	
	
