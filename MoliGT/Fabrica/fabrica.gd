extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var circuito
var automovil = preload("res://Automovil/Automovil/Automovil.tscn")
var circuitos = ["res://Fabrica/Circuito/Circuito1.tscn","res://Fabrica/Circuito/Circuito2.tscn"]


# Called when the node enters the scene tree for the first time.

func make_circuito(i):
	circuito = load(circuitos[i])
	return circuito.instance()

func make_automovil():
	return automovil.instance()

	