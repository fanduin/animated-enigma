extends KinematicBody2D

export (int) var max_speed = 200
export (int) var min_speed = 10
export (int) var speed_decay = 10

var velocity = Vector2()
onready var speed = max_speed

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	set_process(true)

func get_input():
	look_at(get_global_mouse_position())
	velocity = Vector2(speed, 0).rotated(rotation)

func _process(delta):
	get_input()
	speed = clamp(speed - speed_decay * delta, min_speed, max_speed)
	velocity = move_and_slide(velocity)

func _on_Pickup_body_entered(body):
	speed = clamp(speed + 50, min_speed, max_speed)

func _on_Zombie_body_entered(body):
	set_process(false)
