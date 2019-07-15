extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var circuito
var automovil = preload("res://Automovil/Automovil/Automovil.tscn")
var circuitos = ["res://Fabrica/Circuito/Circuito1.tscn","res://Fabrica/Circuito/Circuito2.tscn"]
var coches =   ['res://Fabrica/FAutomovil/cars/car_yellow_s.png',
				"res://Fabrica/FAutomovil/cars/car_blue.png",
				'res://Fabrica/FAutomovil/cars/car_blue_s.png',
				'res://Fabrica/FAutomovil/cars/car_gray_s.png',
				'res://Fabrica/FAutomovil/cars/car_green_s.png',
				'res://Fabrica/FAutomovil/cars/car_purple_s.png',
				'res://Fabrica/FAutomovil/cars/car_red_s.png',
				'res://Fabrica/FAutomovil/cars/car_yellow.png',
				]
var llantas =  ['res://Fabrica/FAutomovil/tires/tires_2.png',
				'res://Fabrica/FAutomovil/tires/tires_gray.png']


# Called when the node enters the scene tree for the first time.

func make_circuito(i):
	circuito = load(circuitos[i])
	return circuito.instance()

func make_automovil(coche,llanta):
	var auto = automovil.instance()
	auto.get_node('Sprite').texture = load(coches[coche])
	auto.get_node('Llantas').texture = load(llantas[llanta])
	return auto

	