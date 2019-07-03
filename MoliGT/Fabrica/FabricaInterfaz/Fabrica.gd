
onready var FAuto = preload("res://Fabrica/FAutomovil/FabricaAutomovil.gd")
onready var FCirc = preload("res://Fabrica/FCircuito/FabricaCircuito.gd")

func crear_circuito(circuito):
	return FCirc.Make(circuito)

func crear_automovil(color):
	return FAuto.Make(color)



