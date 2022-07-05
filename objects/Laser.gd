extends Area2D

var damage_number = load("res://entity/floating_text.tscn")

var source = null
var iff_index = -1
var direction = Vector2(0, -1)
var projectile_speed = 1000
var damage = 5
var laser_color = null

func set_color(color):
	laser_color = color
	self.set_modulate(color)

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
	if get_node("/root/Game").hostility(source, body) && (body.is_in_group("asteroids") || body.is_in_group("ship")):
		var text = damage_number.instance()
		text.set_color(laser_color)
		text.position = self.position
		text.amount = body.apply_damage(damage, self)
		get_node("/root/Game").add_child(text)
		get_parent().call_deferred("remove_child", self)
		self.call_deferred("queue_free")
	else:
		pass
