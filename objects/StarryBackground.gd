extends ParallaxBackground

var star1 = load("res://objects/bg_star.tscn")
var star2 = load("res://objects/bg_star2.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	for _i in range(0,500):
		var temp = null
		if rand_range(0,3) > 1:
			temp = star1.instance()
		else:
			temp = star2.instance()
		temp.scale = Vector2(0.15, 0.15)
		temp.position = Vector2(rand_range(-5000 , 5000), rand_range(-5000,5000))
		$ParallaxLayer1.add_child(temp)
	
	for _i in range(0,500):
		var temp = null
		if rand_range(0,3) > 1:
			temp = star1.instance()
		else:
			temp = star2.instance()
		temp.scale = Vector2(0.1, 0.1)
		temp.position = Vector2(rand_range(-5000, 5000), rand_range(-5000,5000))
		$ParallaxLayer2.add_child(temp)

	for _i in range(0,600):
		var temp = null
		if rand_range(0,3) > 1:
			temp = star1.instance()
		else:
			temp = star2.instance()
		temp.scale = Vector2(0.08, 0.08)
		temp.position = Vector2(rand_range(-5000, 5000), rand_range(-5000,5000))
		$ParallaxLayer2.add_child(temp)
