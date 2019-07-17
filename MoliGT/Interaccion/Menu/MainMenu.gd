extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var join = false
var server = load('res://Servicios/Servidor/MainServer.gd')
var server_ip
var track

func _ready():
	rset_config('track',MultiplayerAPI.RPC_MODE_SYNC)
	# Hide menus and show the firs
	$Main.show()
	$Main/LineEdit.text = record.data.racer_name
	$SelCoche.hide()
	$SelLlantas.hide()
	$SelPista.hide()
	$Client.hide()
	$Server.hide()
	# Load data from file
	record.load()
	# Connect button signals
	$Main/Create.connect('pressed',self,'_on_Create_pressed')
	$Main/Join.connect('pressed',self,'_on_Join_pressed')
	$Main/Record.connect('pressed',self,'_on_Record_pressed')
	$Client/Button.connect('pressed',self,'_on_connect_pressed')
	$Client/Button2.connect('pressed',self,'_on_disconnect_pressed')
	$Server/Button.connect('pressed',self,'on_iniciar_pressed')
	$Server/Button2.connect('pressed',self,'_on_volver_pressed')
	$Server/Timer.connect('timeout',self,'on_iniciar_pressed')
	
	for i in range(8):
		get_node("SelCoche/Coche"+str(i)).connect('pressed',self,'change_car',[i])
	for i in range(2):
		get_node('SelLlantas/Button'+str(i)).connect('pressed',self,'change_tires',[i])
		get_node('SelPista/Bp'+str(i)).connect('pressed',self,'change_track',[i])
		

# Set racer name
func _process(delta):
	record.data.racer_name = $Main/LineEdit.text


func _on_Create_pressed():
	join = false
	$Main.hide()
	$SelPista.show()


func _on_Record_pressed():
	# TODO record
	pass # replace with function body


func _on_Join_pressed():
	join = true
	$Main.hide()
	$SelCoche.show()



# Server button functions
func on_iniciar_pressed():
	rset('track',record.current_track)
	rpc('manual_start')

func _on_volver_pressed():
	print(_disconnect())
	$Server.hide()
	$Main.show()
	pass

# CLient button functions
func _on_connect_pressed():
	client_init($Client/LineEdit.text)

func _on_disconnect_pressed():
	print(_disconnect())
	$Client.hide()
	$Main.show()



#func _input(event):
#	if event.is_action_pressed("Engine"):
#		get_tree().change_scene('res://Servicios/Servidor/Server.tscn')
#	elif event.is_action_pressed("Accelerate"):
#		get_tree().change_scene('res://Carrera/Carrera/Carrera.tscn')



func change_car(id):
	record.current_car = id
	$SelCoche.hide()
	$SelLlantas.show()

func change_tires(id):
	record.current_tires = id
	$SelLlantas.hide()
	if join:
		$Client.show()
	else:
		server_init()
		$Server.show()
		$Server/Timer.start()

func change_track(id):
	record.current_track = id
	$SelPista.hide()
	$SelCoche.show()


func server_init():
	var network = NetworkedMultiplayerENet.new()
	network.create_server(4242, 8)
	get_tree().set_network_peer(network)

	network.connect("peer_connected", self, "_on_player_connected")
	network.connect("peer_disconnected", self, "_on_player_disconnected")

	server_ip = IP.get_local_addresses()
	print(server_ip)



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
	record.players.append(id)
	print('Player '+str(id)+' connected!')
	if get_tree().multiplayer.get_network_connected_peers().size() == 8:
		get_tree().change_scene('res://Carrera/Carrera/Carrera.tscn')
	pass



func _on_player_disconnected(id):
	print('Player '+str(id)+' disconnected!')
	pass



func _on_connection_fail():
	return("Can't connect to server!")
	pass



func _on_connection_success():
	return('Connected to server!')
	pass


sync func manual_start():
	record.current_track = track
	get_tree().change_scene('res://Carrera/Carrera/Carrera.tscn')
	