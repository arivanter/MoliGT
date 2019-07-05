extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var lap
var laps = 3
var pos = [] # arreglo de vectores
var oponents
var grid = []
var counter
var t = null
signal finished

var circuito
const max_corredores = 8
var corredores = []
var player


# Called when the node enters the scene tree for the first time.
func _ready():
	
	randomize()
	record.data.current_race_ID = int(rand_range(0,8))
	print(record.data.current_race_ID)
	
	
	circuito = fabrica.make_circuito()
	add_child(circuito, true)
	for i in max_corredores:
		var car = fabrica.make_automovil()
		car.position = get_node("Circuito1/Grid_"+str(i+1)).position
		car.get_node('Name').text = str(i)
		if i == record.data.current_race_ID:
			car.get_node('Name').text = record.data.racer_name
			car.set_script(load("res://Interaccion/Jugador/Player.gd"))
			car.name = 'Player'
		corredores.append(car)
	for i in corredores:
		add_child(i, true)
	
	
	lap = 0
	counter = 4
	t = Timer.new()
	t.set_wait_time(1)
	t.set_one_shot(true)
	t.connect("timeout", self, "countdown")
	add_child(t)
	t.start()
	
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Player.reving:
		$Player/Camera.zoomout()
	else:
		$Player/Camera.zoomin()
	#llamar a Track/pos
	
	$Player/HUD/Laps.text = str(lap) + '/' + str(laps)
	#$Player/HUD/Pos.text = str(cars.find()) + '/' + str(8)
	# Temp
	$Player/HUD/Pos.text = str(1) + '/' + str(1)
	



func countdown():
	if $Player/HUD/Counter.text == "Go!":
		$Player/HUD/Counter.hide()
		t.queue_free()
		return
	
	counter -= 1
	$Player/HUD/Counter.text = str(counter)
	
	if counter > 0:
		t.start()
	else:
		$Player/HUD/Counter.text = "Go!"
		t.start()
		$Player.switch_engine()



func _on_Track_lap():
	lap += 1
	
	if lap > laps:
		lap = laps
		finish()
		emit_signal("finished")



func finish():
	$Player/HUD/Counter.text = 'Finish!'
	$Player/HUD/Counter.show()

	if $Player.engine:
		$Player.switch_engine()
