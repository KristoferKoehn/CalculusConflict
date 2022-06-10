extends Node2D

var laser_scene = load("res://objects/Laser.tscn")

func shoot():
	var laser = laser_scene.instance()
	laser.global_position = self.global_position
	laser._set_direction_vector(-get_parent().get_rotation_vector())
	laser._set_rotation(get_parent().rotation)
	get_node("/root/Game").add_child(laser)
	
