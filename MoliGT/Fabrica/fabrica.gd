extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.

func make_circuito():
	var circuito = preload("res://Fabrica/Circuito/Circuito1.tscn").instance()
	return circuito

func make_automovil():
	var automovil = preload("res://Automovil/Automovil/Automovil.tscn").instance()
	return automovil

	