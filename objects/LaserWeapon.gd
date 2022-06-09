extends Node2D

var laser_scene = load("res://objects/Laser.tscn")

func shoot():
	var laser = laser_scene.instance()
	laser.global_position = self.global_position - Vector2(14,0)
	get_node("/root/Game").add_child(laser)
