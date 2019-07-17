extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var text = ''
var ip

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func write_text(new):
	text = text + '\n' + new
	$RichTextLabel.text = text
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Connect
func _on_Button_pressed():
	ip = $LineEdit.text
	var network = NetworkedMultiplayerENet.new()
	network.create_client(ip,4242)
	get_tree().set_network_peer(network)
	network.connect('connection_failed', self, '_on_fail')
	network.connect("connection_succeeded", self, '_on_success')
	

# Disconnect
func _on_Button2_pressed():
	get_tree().set_network_peer(null)
	write_text('Desconectado!')

func _input(event):
	if  Input.is_action_just_pressed("ui_accept"):
		_on_Button_pressed()
	



func _on_fail(error):
	write_text(error)
	write_text('No se pudo conectar a ' + ip)
	
func _on_success():
	write_text('Conexión exitosa!')
	
