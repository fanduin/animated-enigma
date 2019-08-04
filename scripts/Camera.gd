extends Node

onready var screen_size = Vector2(
	ProjectSettings.get_setting('display/window/size/width'),
	ProjectSettings.get_setting('display/window/size/height'))

onready var player = get_node("../Player")

func _process(delta):
	var canvas_transform = get_viewport().get_canvas_transform()
	var old_viewport_size = get_viewport().size
	var new_viewport_size = screen_size * player.speed_ratio
	get_viewport().set_size_override(true, new_viewport_size)

	canvas_transform[2] =  (screen_size * player.speed_ratio) / 2 - player.position
	get_viewport().set_canvas_transform(canvas_transform)