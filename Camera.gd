extends Node

onready var screen_size = Vector2(ProjectSettings.get_setting('display/window/size/width'), ProjectSettings.get_setting('display/window/size/height'))

onready var player = get_node("../Player")

func _ready():
	print(screen_size)

func _process(delta):
	print(screen_size)
	var canvas_transform = get_viewport().get_canvas_transform()
	canvas_transform[2] = -player.position + screen_size / 2
	get_viewport().set_canvas_transform(canvas_transform)