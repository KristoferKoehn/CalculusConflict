extends Position2D

onready var label = get_node("Label")
onready var tween = get_node("Tween")

var amount = 0
var text_color = null
# Called when the node enters the scene tree for the first time.
func _ready():
	label.set_text(str(amount))
	label.add_color_override("font_color", text_color)
	tween.interpolate_property(self, 'scale', scale, Vector2(1,1), 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.interpolate_property(self, 'scale', Vector2(1,1), Vector2(0.1,0.1), 0.7, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0.1)
	tween.start()
	
func set_color(color):
	text_color = color

func _on_Tween_tween_all_completed():
	self.queue_free()
