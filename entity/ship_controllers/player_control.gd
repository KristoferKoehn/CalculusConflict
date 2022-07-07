extends Node

var player_ship = null
# Called when the node enters the scene tree for the first time.
func _ready():
	set_player(1, get_node("ship"))

func set_player(index, ship_node):
	#self.add_child(ship_node)
	player_ship = ship_node
	player_ship.add_to_group("player")
	player_ship.iff_index = index

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_pressed("shoot")):
		for i in get_child_count():
			get_children()[i].shoot()
	else:
		for i in get_child_count():
			get_children()[i].end_shoot()
	
	if(Input.is_action_pressed("thrust")):
		for i in get_child_count():
			get_children()[i].thrust()
	else:
		for i in get_child_count():
			get_children()[i].end_thrust()

	if(Input.is_action_pressed("turn_right")):
		for i in get_child_count():
			get_children()[i].rotate_left()
	elif(Input.is_action_pressed("turn_left")):
		for i in get_child_count():
			get_children()[i].rotate_right()
	else:
		for i in get_child_count():
			get_children()[i].end_rotate()
