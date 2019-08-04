extends CanvasLayer

var time_start = 0
var time_now = 0

var dead : = false

onready var player = get_node("../Player")
onready var speed_label = $MarginContainer/VBoxContainer/HBoxContainer/Speed
onready var time_label = $MarginContainer/VBoxContainer/HBoxContainer/Time
onready var dead_label = $MarginContainer/VBoxContainer/Dead
onready var restart_time = $MarginContainer/VBoxContainer/RestartTime
onready var restart_timer = $RestartTimer

func _ready():
	time_start = OS.get_unix_time()
	set_process(true)

func _process(delta):
	if not dead:
		time_now = OS.get_unix_time()
		var elapsed = time_now - time_start
		var minutes = elapsed / 60
		var seconds = elapsed % 60
		speed_label.text = "%d" % player.speed
		time_label.text = "%02d : %02d" % [minutes, seconds]
	else:
		restart_time.text = "%d" % (restart_timer.time_left + 1)


func _on_Zombie_player_dead():
	dead = true
	dead_label.visible = true
	restart_time.visible = true
	restart_timer.start()


func _on_RestartTimer_timeout():
	get_tree().change_scene("scenes/Boot.tscn")
