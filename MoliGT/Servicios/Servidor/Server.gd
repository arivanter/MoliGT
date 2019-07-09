extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var races = []
var race = []
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
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func write_text(new):
	text = text + '\n' + new
	$RichTextLabel.text = text

func _on_connected(id):
	write_text('Jugador '+str(id)+' conectdo!')
	# TODO make race happen
	pass

func _on_disconnected(id):
	write_text('Jugador '+str(id)+' desconectado!')
	# TODO make ai work in place of player
	pass
