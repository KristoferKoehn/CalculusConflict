extends Area2D

var damage_number = load("res://entity/floating_text.tscn")

var player_index = -1
var direction = Vector2(0, -1)
var projectile_speed = 1000
var pierce = false
var damage = 5
var laser_color = null
var fire = false
var fire_magnitude = 0
var fire_delay = 0
var fire_length = 0

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
	if (body.is_in_group("asteroids")):
		if !body.exploded:
			
			#fire check
			if body.is_in_group("flamable"):
				if fire:
					body.last_player_damaged = player_index
					body.ignite(fire_magnitude, fire_length, fire_delay)
				
			else:
				body.last_player_damaged = player_index
			#end fire check. This needs to be better.
			if(body.health < damage && pierce):
				body.last_player_damaged = player_index
				damage = damage - body.health
				var text = damage_number.instance()
				text.set_color(laser_color)
				text.amount = body.health
				text.position = self.position
				get_node("/root/Game").add_child(text)
			else:
				body.health = body.health - damage
				var text = damage_number.instance()
				text.set_color(laser_color)
				text.amount = damage
				text.position = self.position
				get_node("/root/Game").add_child(text)
				get_parent().call_deferred("remove_child", self)
				self.call_deferred("queue_free")
		else:
			pass
