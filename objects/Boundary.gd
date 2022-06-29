extends Node2D

func _ready():
	pass

func _on_BoundaryArea_body_exited(body):
	if body.is_in_group("player"):
		body.out_of_bounds = true

func _on_BoundaryArea_body_entered(body):
	if body.is_in_group("player"):
		body.out_of_bounds = false
