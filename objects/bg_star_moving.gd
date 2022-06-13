extends Sprite


var move_scale = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	self.position.y = self.position.y + (move_scale * delta * 4)
	
	if(self.position.y > 1050):
		self.position.y = -950
