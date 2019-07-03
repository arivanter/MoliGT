extends Area2D

var id
var passed
signal passed(id)



func _on_Checkpoint_body_entered(body):
	emit_signal("passed",id)
