extends CanvasLayer

var time_start = 0
var time_now = 0

onready var player = get_node("../Player")
onready var speed_label = get_node("MarginContainer/HBoxContainer/Speed")
onready var time_label = get_node("MarginContainer/HBoxContainer/Time")

func _ready():
	time_start = OS.get_unix_time()
	set_process(true)

func _process(delta):
	time_now = OS.get_unix_time()
	var elapsed = time_now - time_start
	var minutes = elapsed / 60
	var seconds = elapsed % 60
	speed_label.text = "%d" % player.speed
	time_label.text = "%02d : %02d" % [minutes, seconds]

func _on_Zombie_body_entered(body):
	set_process(false)
