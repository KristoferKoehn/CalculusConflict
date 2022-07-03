extends Node2D

var star1 = load("res://objects/backgrounds/bg_star_moving.tscn")
var star2 = load("res://objects/backgrounds/bg_star2_moving.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for _i in range(0,100):
		var temp = null
		if rand_range(0,3) > 1:
			temp = star1.instance()
		else:
			temp = star2.instance()
		temp.scale = Vector2(0.15, 0.15)
		temp.move_scale = 80
		temp.position = Vector2(rand_range(-1000 , 1000), rand_range(-1000,1000))
		self.add_child(temp)
	
	for _i in range(0,100):
		var temp = null
		if rand_range(0,3) > 1:
			temp = star1.instance()
		else:
			temp = star2.instance()
			
		temp.scale = Vector2(0.1, 0.1)
		temp.move_scale = 60
		temp.position = Vector2(rand_range(-1000, 1000), rand_range(-1000,1000))
		self.add_child(temp)

	for _i in range(0,120):
		var temp = null
		if rand_range(0,3) > 1:
			temp = star1.instance()
		else:
			temp = star2.instance()
		
		temp.move_scale = 40
		temp.scale = Vector2(0.08, 0.08)
		temp.position = Vector2(rand_range(-1000, 1000), rand_range(-1000,1000))
		self.add_child(temp)

