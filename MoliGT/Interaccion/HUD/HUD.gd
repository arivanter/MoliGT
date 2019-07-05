extends CanvasLayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	$Counter.text = 'Ready!'
	$ColorRect.hide()

#func _process(delta):
#	if Input.is_action_just_pressed("Quit"):
#		if $ColorRect.is_visible_in_tree():
#			$ColorRect.hide()
#		else:
#			$ColorRect.show()


func _on_Button_pressed():
	get_tree().change_scene("res://Carrera/Carrera/Carrera.tscn")


func _on_Yes_pressed():
	get_tree().change_scene("res://Interaccion/Menu/MainMenu.tscn")


func _on_No_pressed():
	$ColorRect.hide()
	
func _input(event):
	if Input.is_action_just_pressed('ui_pause'):
		if $ColorRect.visible == false:
			$ColorRect.show()
		else:
			$ColorRect.hide()
