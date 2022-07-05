extends RigidBody2D

var exploded = false
var hull = 15
var last_player_damaged = -1
var iff_index = 0

func _ready():
	pass

func _process(delta):
	if hull < 1:
		explode()

func explode():
	$CollisionShape2D.disabled = true
	if(exploded):
		return
	exploded = true;
	get_parent().remove_child(self)
	queue_free()

func get_health():
	return hull

func set_death_timer(time):
	$DeathTimer.wait_time = time
	$DeathTimer.autostart = true

func _on_Timer_timeout():
	hull = 0

func apply_damage(damage, source):
	hull = hull - damage
	last_player_damaged = source.iff_index
	return damage
