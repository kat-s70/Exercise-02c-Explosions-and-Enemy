extends KinematicBody2D

var velocity = Vector2.ZERO
var initial_speed = 3.0
var small_speed = 3.0

onready var Asteroid_Small = load("res://Asteroid/Asteroid_Small.tscn")
var health = 1
var small_asteroids = [Vector2(0, -30), Vector2(30, 30), Vector2(-30, 30)]


func _ready():
	velocity = Vector2(0,initial_speed*randf()).rotated(PI*2*randf())

func _physics_process(_delta):
	position = position + velocity
	position.x = wrapf(position.x, 0, 1024)
	position.y = wrapf(position.y, 0, 600)

func damage(d):
	health -= d
	if health <= 0:
		collision_layer = 0
		var Asteroid_Container = get_node_or_null("/root/Game/Asteroid_Container")
		if Asteroid_Container != null:
			for s in small_asteroids:
				var asteroid_small = Asteroid_Small.instance()
				var direction = randf()*2*PI
				var i = Vector2(0, randf()*small_speed).rotated(direction)
				Asteroid_Container.call_deferred("add_child", asteroid_small)
				asteroid_small.position = position + s.rotated(direction)
				asteroid_small.velocity = i
		queue_free()
