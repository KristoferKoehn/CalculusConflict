extends Node

var asteroid_scene = load("res://objects/Asteroid.tscn")

func _ready():
	_spawn_asteroid()

func _spawn_asteroid():
	var asteroid = asteroid_scene.instance()
	_set_asteroid_position(asteroid)
	_set_asteroid_trajectory(asteroid)
	asteroid.set_death_timer(14)
	add_child(asteroid)

func _set_asteroid_trajectory(asteroid):
	asteroid.angular_velocity = rand_range(-4,4)
	asteroid.angular_damp = 0
	var direction = Vector2(500*cos(rand_range(0.0,2.0)*PI) - asteroid.position.x, 500*sin(rand_range(0.0,2.0)*PI) - asteroid.position.y).normalized()
	asteroid.linear_velocity =  direction * rand_range(300,500)
	asteroid.linear_damp = 0

func _set_asteroid_position(asteroid):
	var point = rand_range(0.0,2.0)*PI
	asteroid.position = Vector2(2600*cos(point), 2600*sin(point))

func _on_Timer_timeout():
	_spawn_asteroid()
