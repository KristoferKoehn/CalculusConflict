extends Node

var stat_mod = load("res://entity/ship_stats/stat_mod.tscn")

var value = null
var stat = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _recalculate():
	var values_list = [0,1,1]
	var mod_list = self.get_children()
	for i in range(len(mod_list)):
		values_list[mod_list[i].type] += mod_list[i].value

	value = values_list[enums.modifier_type.flat] * values_list[enums.modifier_type.additive]

func add_mod(value_, mod_type = enums.modifier_type.flat):
	var temp = stat_mod.instance()
	temp.type = mod_type
	temp.value = value_
	self.add_child(temp)
	_recalculate()
