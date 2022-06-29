extends RigidBody2D

var exploded = false
var health = 15
var last_player_damaged = -1
var team = 0

var on_fire = false
var fire_magnitude = 0
var fire_tick_count = 0
var fire_length = 0

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

func _on_fire_timeout():
	if fire_tick_count == fire_length:
		self.fire_timer.stop()
	else:
		pass
		#put some shit here idk
	
func ignite(magnitude, length, delay):
	if on_fire:
		self.fire_tick_count = 0
	else:
		self.fire_magnitude = magnitude
		self.fire_length = length
		self.on_fire = true
		self.fire_timer.wait_time = delay
		self.fire_timer.start()
	
	
