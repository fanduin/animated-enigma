extends KinematicBody2D

onready var animation_player : = $AnimationPlayer

export (int) var max_speed = 200
export (int) var min_speed = 10
export (int) var speed_decay = 10

var velocity = Vector2()
var speed_ratio : float
onready var speed = max_speed

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	animation_player.play("Run")
	set_process(true)

func get_input():
	look_at(get_global_mouse_position())
	velocity = Vector2(speed, 0).rotated(rotation)

func _process(delta):
	get_input()
	speed = clamp(speed - speed_decay * delta, min_speed, max_speed)
	speed_ratio = speed / max_speed
	animation_player.playback_speed = speed_ratio
	velocity = move_and_slide(velocity)

func _on_Pickup_body_entered(body):
	speed = clamp(speed + 25, min_speed, max_speed)

func _on_Zombie_player_dead():
	animation_player.playback_speed = 1
	animation_player.play("Dead")
	set_process(false)
