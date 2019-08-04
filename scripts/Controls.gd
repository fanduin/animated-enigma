extends Node2D

func _input(event):
	if event is InputEventMouseButton:
		yield(get_tree().create_timer(0.5), "timeout")
		get_tree().change_scene("scenes/Main.tscn")