extends Tween

var dir = 0

func _ready():
	move()

func _process(delta):
	pass
	
func move():
	
	if dir == 0:
		interpolate_property($TileMap, "position", 
		Vector2(438.510986, 471.709045), Vector2(-230, 471.709045), 5,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	else:
		interpolate_property($TileMap, "position",
	    Vector2(-230, 471.709045), Vector2(438.510986, 471.709045), 5,
	    Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		
	start()


func _on_Tween_tween_completed(object, key):
	if dir == 1:
		dir = 0
	else:
		dir = 1
	move()
