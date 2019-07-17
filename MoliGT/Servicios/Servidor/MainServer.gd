extends Node2D


var server_ip
var track


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func server_init():
	var network = NetworkedMultiplayerENet.new()
	network.create_server(4242, 8)
	get_tree().set_network_peer(network)

	network.connect("peer_connected", self, "_on_player_connected")
	network.connect("peer_disconnected", self, "_on_player_disconnected")

	server_ip = IP.get_local_addresses()



func client_init(ip):
	var network = NetworkedMultiplayerENet.new()
	network.create_client(ip,4242)
	get_tree().set_network_peer(network)
	network.connect('connection_failed', self, '_on_connection_fail')
	network.connect("connection_succeeded", self, '_on_connection_success')



func _disconnect():
	get_tree().set_network_peer(null)
	return('Disconnected from server!')


func _on_player_connected(id):
	return('Player '+str(id)+' connected!')
	if get_tree().multiplayer.get_network_connected_peers().size() == 8:
		get_tree().change_scene('res://Carrera/Carrera/Carrera.tscn')
	pass



func _on_player_disconnected(id):
	return('Player '+str(id)+' disconnected!')
	pass



func _on_connection_fail():
	return("Can't connect to server!")
	pass



func _on_connection_success():
	return('Connected to server!')
	pass


sync func manual_start():
	get_tree().change_scene('res://Carrera/Carrera/Carrera.tscn')
	