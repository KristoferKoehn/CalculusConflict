extends RigidBody2D

var exploded = false
var health = 15

func _ready():
	pass

func _process(delta):
	if health < 1:
		explode()

func explode():
	$CollisionShape2D.disabled = true
	if(exploded):
		return
	exploded = true;
	get_parent().remove_child(self)
	queue_free()

func get_health():
	return health
	
func set_death_timer(time):
	$DeathTimer.wait_time = time
	$DeathTimer.autostart = true

func _on_Timer_timeout():
	health = 0
