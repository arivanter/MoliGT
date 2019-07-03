extends TileMap

onready var posP1 = Vector2(-243.871338,44.236465)
onready var posP2 = Vector2(-401.769958,-67.023651)
onready var posP3 = Vector2(622.237244,-16.194183)
var t = Timer.new()


func _ready():
	$Player.switch_engine()
	$Player2.switch_engine()
	$Player3.switch_engine()
	set_physics_process(true)
	t.set_wait_time(7)
	t.set_one_shot(true)
	t.connect("timeout", self, "anim")
	add_child(t)
	t.start()

func _physics_process(delta):
	$Player.accel()
	$Player2.accel()
	$Player3.accel()
	$Player.rot = -PI/2
	
	$Player2.rot = -PI/2
	$Player3.rot = PI/2
	

func anim():
	$Player.position = posP1
	$Player2.position = posP2
	$Player3.position = posP3
	t.start()
	
