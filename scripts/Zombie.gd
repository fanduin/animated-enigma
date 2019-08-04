extends Area2D

signal player_dead

onready var nav_2d : Navigation2D = get_node("../Navigation2D")
onready var line_2d : Line2D = get_node("../Line2D")
onready var player	: KinematicBody2D = get_node("../Player")

onready var head : Sprite = $Head
onready var body : Sprite = $Body
onready var collision_shape_2d = $CollisionShape2D

export (int) var speed : = 20
export (float) var rotate_speed : = 1

var path : = PoolVector2Array() setget set_path

func _ready():
	set_process(true)

func _process(delta : float):
	path = nav_2d.get_simple_path(global_position, player.global_position)
	line_2d.points = path
	
	head.look_at(player.global_position)
	head.rotate(PI / 2)
	if path:
		body.look_at(path[1])
		body.rotate(PI / 2)
	else:
		body.look_at(player.global_position)
	collision_shape_2d.rotation = body.rotation
	
	var move_distance : = speed * delta
	move_along_path(move_distance)

func _on_Zombie_body_entered(body):
	if body.get_name() == "Player":
		emit_signal("player_dead")
		queue_free()

func move_along_path(distance : float) -> void:
	var start_point : = position
	for i in range(path.size()):
		var distance_to_next : = start_point.distance_to(path[0])
		if distance >= 0.0 and distance < distance_to_next:
			position = start_point.linear_interpolate(path[0], distance / distance_to_next)
			break
		elif distance < 0.0:
			position = path[0]
			break
		distance -= distance_to_next
		start_point = path[0]
		path.remove(0)

func set_path(value : PoolVector2Array) -> void:
	path = value
	if value.size() == 0:
		return
	set_process(true)