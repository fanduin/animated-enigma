extends Area2D

onready var nav_2d : Navigation2D = get_node("../Navigation2D")
onready var line_2d : Line2D = get_node("../Line2D")
onready var player	: KinematicBody2D = get_node("../Player")

export (int) var speed : = 20

var path : = PoolVector2Array() setget set_path

func _ready():
	set_process(true)

func _process(delta : float):
	path = nav_2d.get_simple_path(global_position, player.global_position)
	line_2d.points = path
	var move_distance : = speed * delta
	move_along_path(move_distance)

func _on_Zombie_body_entered(body):
	print(body)
	queue_free()

func move_along_path(distance : float) -> void:
	print(distance)
	var start_point : = position
	for i in range(path.size()):
		var distance_to_next : = start_point.distance_to(path[0])
		if distance >= 0.0 and distance < distance_to_next:
			print("Distance %d" % distance)
			print("Next %d" % distance_to_next)
			position = start_point.linear_interpolate(path[0], distance / distance_to_next)
			break
		elif distance < 0.0:
			position = path[0]
			set_process(false)
			break
		distance -= distance_to_next
		start_point = path[0]
		path.remove(0)

func set_path(value : PoolVector2Array) -> void:
	path = value
	if value.size() == 0:
		return
	set_process(true)