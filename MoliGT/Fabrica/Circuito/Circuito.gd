extends TileMap


onready var pos = preload("res://Fabrica/Circuito/Position.gd").new()
var allchecks
var checks = []
var checknum = 4
signal lap



func _ready():
	allchecks = false
	for i in range(checknum):
		var checkstr = "Checkpoint" + str(i)
		checks.append(get_node(checkstr))
		checks[i].id = i
		checks[i].passed = false



func _on_Start_body_entered(body):
	if allchecks:
		emit_signal("lap")
	allchecks = false
	for i in checks:
		i.passed = false
		print(str(i.id) + str(i.passed))
	print(allchecks)



func _on_Checkpoint_body_entered(id):
	checks[id].passed = true
	allchecks = true
	for i in checks:
		print(str(i.id) + str(i.passed))
		if i.passed == false:
			allchecks = false
	print(allchecks)
	
