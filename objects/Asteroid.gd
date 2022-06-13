extends RigidBody2D

var exploded = false

func _ready():
	pass

func explode():
	$CollisionShape2D.disabled = true
	if(exploded):
		return
	exploded = true;
	get_parent().remove_child(self)
	queue_free()
	
	
func _kill():
	if(exploded):
		return
	exploded = true;
	get_parent().remove_child(self)
	queue_free()
	
func set_death_timer(time):
	$DeathTimer.wait_time = time
	$DeathTimer.autostart = true


func _on_Timer_timeout():
	_kill()
