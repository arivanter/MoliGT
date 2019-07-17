extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var circuito
var player_num
var players = []
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	circuito = fabrica.make_circuito(record.current_track)
	circuito.connect('lap',self,"_on_Track_lap")
	add_child(circuito, true)
	
	player = fabrica.make_automovil(record.current_car, record.current_tires)
	player.get_node('Name').text = record.data.racer_name
	player.set_name(str(get_tree().get_network_unique_id()))
	print('me: '+str(get_tree().get_network_unique_id()))
	player.set_script(load("res://Interaccion/Jugador/Player.gd"))
	
	player.set_network_master(get_tree().get_network_unique_id())
	
	player.position = get_node("Circuito"+str(record.current_track+1)+"/Grid_1").position
	
	add_child(player)
	
	record.players.append(1)
	
	
	
	var car= fabrica.make_automovil(record.current_car, record.current_tires)
	car.get_node('Name').text = str(record.players[0])
	car.set_name(str(record.players[0]))
		
	car.set_network_master(record.players[0])
	print('other: '+str(record.players[0]))
	
	car.position = get_node("Circuito"+str(record.current_track+1)+"/Grid_2").position
	add_child(car)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
