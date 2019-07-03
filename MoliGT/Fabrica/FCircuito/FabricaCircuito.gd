
func Make(circuito):
	var circ = load("res://Fabrica/Circuito/Circuito" + str(circuito) + ".tscn")
	var Pista = circ.instance()
	return Pista