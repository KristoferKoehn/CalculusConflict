extends Particles2D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func update_color():
	var color_pool = self.process_material.color_ramp.gradient.colors
	color_pool.remove(0)
	color_pool.invert()
	color_pool.append(get_parent().player_color)
	color_pool.invert()
	self.process_material.color_ramp.gradient.colors = color_pool
	print(get_parent().player_color)
	print(self.process_material.color_ramp.gradient.colors)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
