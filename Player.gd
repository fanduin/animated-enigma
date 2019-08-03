extends KinematicBody2D

signal move

export (int) var speed = 200

var velocity = Vector2()

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)

func get_input():
    look_at(get_global_mouse_position())
    velocity = Vector2(speed, 0).rotated(rotation)

func _physics_process(delta):
    get_input()
    velocity = move_and_slide(velocity)