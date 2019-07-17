extends Node

var lap
var laps = 3
var counter
var t = null
signal finished
var id

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
	
	id = get_tree().get_network_unique_id()
	
	player = fabrica.make_automovil(record.current_car, record.current_tires)
	player.get_node('Name').text = record.data.racer_name
	player.set_name(str(get_tree().get_network_unique_id()))
	player.set_script(load("res://Interaccion/Jugador/Player.gd"))

	player.set_network_master(get_tree().get_network_unique_id())
	
	record.players.append(get_tree().get_network_unique_id())

	var car_count = 0
	var adding
	for i in record.players:
		adding = fabrica.make_automovil(randi()%8, randi()%2)
		adding.get_node('Name').text = str(i)
		adding.set_name(str(i))
		adding.set_network_master(i)
		
		if i == get_tree().get_network_unique_id():
			adding = player
		
		adding.position = get_node("Circuito"+str(record.current_track+1)+"/Grid_"+str(car_count+1)).position
		add_child(adding)
		car_count += 1

	while car_count < 8:
		adding = fabrica.make_automovil(randi()%8, randi()%2)
		adding.get_node('Name').text = str(car_count)
		adding.set_name(str(car_count))
		adding.position = get_node("Circuito"+str(record.current_track+1)+"/Grid_"+str(car_count+1)).position
		add_child(adding)
		car_count += 1
	
	lap = 1
	counter = 4
	t = Timer.new()
	t.set_wait_time(1)
	t.set_one_shot(true)
	t.connect("timeout", self, "countdown")
	add_child(t)
	t.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_node(str(id)).reving:
		get_node(str(id)+'/Camera').zoomout()
	else:
		get_node(str(id)+'/Camera').zoomin()
	#llamar a Track/pos
	
	get_node(str(id)+'/HUD/Laps').text = str(lap) + '/' + str(laps)



func countdown():
	if get_node(str(id)+'/HUD/Counter').text == "Go!":
		get_node(str(id)+'/HUD/Counter').hide()
		t.queue_free()
		return
	
	counter -= 1
	get_node(str(id)+'/HUD/Counter').text = str(counter)
	
	if counter > 0:
		t.start()
	else:
		get_node(str(id)+'/HUD/Counter').text = "Go!"
		t.start()
		get_node(str(id)).start()



func _on_Track_lap():
	lap += 1
	
	if lap > laps:
		lap = laps
		finish()
		emit_signal("finished")



func finish():
	get_node(str(id)+'/HUD/Counter').text = 'Finish!'
	get_node(str(id)+'/HUD/Counter').show()

	if get_node(str(id)).engine:
		get_node(str(id)).start()

