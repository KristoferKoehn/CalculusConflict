extends Area2D

var direction = Vector2(0, -1)
var projectile_speed = 1000


func _process(delta):
	self.position += direction * projectile_speed * delta


func _on_Timer_timeout():
	queue_free()
	
func set_direction_vector(dir):
	direction = -dir
	
func set_rotation(rot):
	rotation = rot

func set_speed(speed):
	projectile_speed = speed


func _on_Laser_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if (body.is_in_group("asteroids")):
		if !body.exploded:
			body.call_deferred("explode")
			get_parent().call_deferred("remove_child", self)
			queue_free()
		else:
			pass
