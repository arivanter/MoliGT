extends Node2D

# Diccionario de datos que contiene toda la informacion del jugador (su savedata)
var data = {
	'current_race_id':0,
	'racer_name':'Hiram',
	'car1':{
		'track1':{
			'best_lap':0,
			'total_races':10,
			'victories':5,
		},
	},
}



func save():
	var f = File.new()
	var file = 'user://savedata.json'
	f.open(file, File.WRITE)
	f.store_line(to_json(data))
	f.close()



func load():
	var f = File.new()
	var file = 'user://savedata.json'
	if f.file_exists(file):
		f.open(file, File.READ)
	else:
		return false
	var res = parse_json(f.get_line())
	data = res
	f.close()
	return true


## Called when the node enters the scene tree for the first time.
#func _ready():
#	print(data)
#	save()
#	self.load()
#	print(data)
#	data.auto1 = 'red'
#	print(data)
#	data.erase("auto1")
#	print(data)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
