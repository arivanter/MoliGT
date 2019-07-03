extends Area2D

var id
var passed
signal passed(id)



func _on_Checkpoint_body_entered(body):
	if body is KinematicBody2D:
		if body.is_player:
			emit_signal("passed",id)
