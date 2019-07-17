extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var text = ''
var ip
# Called when the node enters the scene tree for the first time.
func _ready():
	var network = NetworkedMultiplayerENet.new()
	network.create_server(4242, 8)
	get_tree().set_network_peer(network)
	
	network.connect("peer_connected", self, "_on_connected")
	network.connect("peer_disconnected", self, "_on_disconnected")
	
	ip = IP.get_local_addresses()
	write_text('Adresses: '+str(ip))
	_on_connected(get_tree().multiplayer.get_network_unique_id())
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.text = 'La carrera comienza en:\n'+str($Timer.time_left)
	pass

func write_text(new):
	text = text + '\n' + new
	$RichTextLabel.text = text

func _on_connected(id):
	write_text('Jugador '+str(id)+' conectdo!')
	if record.race.size() < 8:
		record.race.append(id)
	else:
		rpc('begin_race')
	if get_tree().multiplayer.get_network_connected_peers().size() == 1:
		$Timer.start()
		
	# TODO make race happen
	pass

func _on_disconnected(id):
	write_text('Jugador '+str(id)+' desconectado!')
	# TODO make ai work in place of player
	pass



func _on_Timer_timeout():
	rpc('serve.begin')



func _on_Button_pressed():
	rpc('serve.begin')

func _on_Button2_pressed():
	get_tree().change_scene('res://Interaccion/Menu/MainMenu.tscn')

