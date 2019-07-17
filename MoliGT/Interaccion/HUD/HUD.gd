extends CanvasLayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var face_crash 
var face_normal

func _ready():
	$Counter.text = 'Ready!'
	$ColorRect.hide()
	get_parent().get_node('Area2D').connect('body_entered',self,'_on_Area2D_body_entered')
	get_parent().get_node('Area2D').connect('body_exited',self,'_on_Area2D_body_exited')

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
			
			
func _on_Area2D_body_entered(body):
	if body != self:
		if get_parent().is_player:
			$face.texture = face_crash




func _on_Area2D_body_exited(body):
	if body != self:
		if get_parent().is_player:
			$face.texture = face_normal