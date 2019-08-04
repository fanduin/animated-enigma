extends Area2D

var speed_increase = 50

func _on_Pickup_body_entered(body):
	queue_free()
