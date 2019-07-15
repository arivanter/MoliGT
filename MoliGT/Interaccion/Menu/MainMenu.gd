extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	$Main.show()
	$SelCoche.hide()
	$SelLlantas.hide()
	$SelPista.hide()
	record.load()
	$Main/Create.connect('pressed',self,'_on_Create_pressed')
	$Main/Join.connect('pressed',self,'_on_Join_pressed')
	$Main/Record.connect('pressed',self,'_on_Record_pressed')
	for i in range(8):
		get_node("SelCoche/Coche"+str(i)).connect('pressed',self,'change_car',[i])
	for i in range(2):
		get_node('SelLlantas/Button'+str(i)).connect('pressed',self,'change_tires',[i])
		get_node('SelPista/Bp'+str(i)).connect('pressed',self,'change_track',[i])
		

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Create_pressed():
	$Main.hide()
	$SelPista.show()


func _on_Record_pressed():
	pass # replace with function body


func _on_Join_pressed():
	$Main.hide()
	$SelCoche.show()
	
func _input(event):
	if event.is_action_pressed("Engine"):
		get_tree().change_scene('res://Servicios/Servidor/Server.tscn')
	elif event.is_action_pressed("Accelerate"):
		get_tree().change_scene('res://Carrera/Carrera/Carrera.tscn')



func change_car(id):
	record.current_car = id
	$SelCoche.hide()
	$SelLlantas.show()

func change_tires(id):
	record.current_tires = id
	$SelLlantas.hide()
	get_tree().change_scene('res://Carrera/Carrera/Carrera.tscn')

func change_track(id):
	record.current_track = id
	$SelPista.hide()
	$SelCoche.show()