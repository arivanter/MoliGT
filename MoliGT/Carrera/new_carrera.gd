extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var circuito
const max_corredores = 8
var corredores = []
var player


# Called when the node enters the scene tree for the first time.
func _ready():
	circuito = fabrica.make_circuito()
	add_child(circuito)
	for i in max_corredores:
		var car = fabrica.make_automovil()
		car.position = get_node("circuito/Grid_"+str(i+1))
		if i == 0:
			car.set_script("res://Interaccion/Jugador/Player.gd")
		corredores.append(car)
	for i in corredores:
		var grid_str = 'Grid_' + 
		pass
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
