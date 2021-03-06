extends entity



var shooting = false
var thrusting = false
var camera_targeted = false

func _ready():
	update_colors(player_color)
	stat_manager = get_node("stat_manager")
	stat_manager.initialize()

func thrust():
	self.velocity += Vector2(cos(self.rotation - PI/2.0), sin(self.rotation - PI/2.0)) * stat_manager.get_stat(enums.modifier_stat.thrust_acceleration)
	thrusting = true

func end_thrust():
	thrusting = false

func shoot():
	shooting = true

func end_shoot():
	shooting = false

func rotate_left(magnitude = 1):
	rotate = magnitude

func rotate_right(magnitude = 1):
	rotate = -1 * magnitude

func end_rotate():
	rotate = 0

func _process(_delta):
	if shooting:
		weapon.shoot()
	
	if self.is_in_group("camera target") && !camera_targeted:
		self.get_node("/root/Game/Arena_Level/MultiTargetCamera").add_target(self)
		camera_targeted = true
	
func _physics_process(delta: float) -> void:

	if (thrusting):
		.get_node("EngineParticles").emitting = true
		if !.get_node("EngineNoise").playing:
			.get_node("EngineNoise").play()
	else:
		.get_node("EngineNoise").stop()
		.get_node("EngineParticles").emitting = false

func update_colors(color):
	self.player_color = color
	self.get_node("Sprite").modulate = self.player_color
	self.get_node("EngineParticles").update_color()
	self.get_node("LaserWeapon").update_color() 
