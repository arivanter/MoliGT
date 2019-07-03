extends Node2D

var lap
var laps = 3
var pos = [] # arreglo de vectores
var cars = []
var oponents
var grid = []
var counter
var t = null
signal finished


func _ready():
	lap = 0
	counter = 4
	t = Timer.new()
	t.set_wait_time(1)
	t.set_one_shot(true)
	t.connect("timeout", self, "countdown")
	add_child(t)
	t.start()
	
	for i in range(8):
		var gridPosStr = "World/Track/Grid_" + str(i+1)
		grid.append(get_node(gridPosStr).position)
		



func _process(delta):
	
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
		finish()
		emit_signal("finished")



func finish():
	$Player/HUD/Counter.text = 'Finish!'
	$Player/HUD/Counter.show()

	if $Player.engine:
		$Player.switch_engine()
