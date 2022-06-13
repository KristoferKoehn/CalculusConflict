extends Node2D

signal start_arena

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var current_level = null

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/start_button.grab_focus()



func _process(_delta):
	if $VBoxContainer/start_button.has_focus():
		$selector.position = lerp($selector.position, $start_button_position.position, .4)
	if $VBoxContainer/settings_button.has_focus():
		$selector.position = lerp($selector.position, $settings_button_position.position, .4)


func _on_start_button_pressed():
	emit_signal("start_arena")
