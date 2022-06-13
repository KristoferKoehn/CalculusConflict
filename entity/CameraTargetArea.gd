extends Area2D

var list = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	
	if body.is_in_group("camera target"):
		get_node("/root/Game/MultiTargetCamera").add_target(self)
	
	


func _on_Area2D_body_exited(body):
	get_node("/root/Game/MultiTargetCamera").remove_target(self)
