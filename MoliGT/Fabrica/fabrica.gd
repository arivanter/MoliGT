extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var circuito = preload("res://Fabrica/Circuito/Circuito1.tscn")
var automovil = preload("res://Automovil/Automovil/Automovil.tscn")

# Called when the node enters the scene tree for the first time.

func make_circuito():
	return circuito.instance()

func make_automovil():
	return automovil.instance()

	