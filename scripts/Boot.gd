extends Node2D

onready var screen_size = Vector2(
	ProjectSettings.get_setting('display/window/size/width'),
	ProjectSettings.get_setting('display/window/size/height'))

func _ready():
	var canvas_transform = get_viewport().get_canvas_transform()
	get_viewport().set_size_override(true, screen_size)

	canvas_transform[2] =  Vector2(0, 0)
	get_viewport().set_canvas_transform(canvas_transform)

func _input(event):
	if event is InputEventMouseButton:
		yield(get_tree().create_timer(0.5), "timeout")
		get_tree().change_scene("scenes/Controls.tscn")