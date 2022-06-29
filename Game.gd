extends Node2D

var arena = load("res://levels/Arena_Level.tscn")
var start_screen = load("res://levels/start_screen.tscn")
var current_scene = null

#player management stuff
var current_players = 1
var player_colors = []
var player_scores = [0,0,0,0,0,0]

var iff_matrix = [[0,1,1,1,1,1,1,1],
[1,0,0,0,0,0,0,1],
[1,0,0,0,0,0,0,1],
[1,0,0,0,0,0,0,1],
[1,0,0,0,0,0,0,1],
[1,0,0,0,0,0,0,1],
[1,0,0,0,0,0,0,1],
[1,1,1,1,1,1,1,0]]

func _ready():
	player_colors.append(Color(0,1.2,0,1))
	player_colors.append(Color(1.15,0,1.15,1))

	var title = start_screen.instance()
	title.connect("start_arena", self, "_on_load_arena")
	self.add_child(title)
	current_scene = title

func _process(_delta):
	pass

func _on_load_arena():
	var next_level = arena.instance()
	self.remove_child(current_scene)
	self.add_child(next_level)
	current_scene = next_level
