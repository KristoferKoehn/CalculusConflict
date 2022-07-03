extends Node

var enums = load("res://script classes/enum_class.gd")

var value = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _recalculate():
	var values_list = [0,1,1]
	var mod_list = self.get_children()
	for i in range(len(mod_list)):
		values_list[mod_list.modifier_type] = mod_list.value

	value = values_list[enums.modifier_types.flat] * values_list[enums.modifier_types.additive]
