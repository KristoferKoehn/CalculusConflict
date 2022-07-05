extends Node

var stat = load("res://entity/ship_stats/stat.tscn")

func initialize():
		for i in range(0,enums.modifier_stat.size()):
			var temp = stat.instance()
			temp.stat = i
			##this gets the base stats for the ship.
			temp.add_mod(get_parent().stat_block[i])
			self.add_child(temp)

func get_stat(statType):
	var children = get_children()
	for i in range(0, children.size()):
		if children[i].stat == statType:
			return children[i].value
