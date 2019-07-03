extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Create_pressed():
	$CanvasLayer/ColorRect.show()
	$Tween/TileMap.hide()
	get_tree().change_scene("res://Carrera/Carrera/Carrera.tscn")


func _on_Record_pressed():
	pass # replace with function body


func _on_Join_pressed():
	pass # Replace with function body.
