extends CanvasLayer

var num_players = null



# Called when the node enters the scene tree for the first time.
func _ready():
	num_players = get_node("/root/Game").current_players
	for i in range(0, num_players):
		get_children()[i].add_color_override("font_color", get_node("/root/Game").player_colors[i])
		get_children()[i].visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
